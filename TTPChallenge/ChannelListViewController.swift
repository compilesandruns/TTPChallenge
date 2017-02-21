//
//  ChannelListViewController.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/19/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Firebase

enum ChannelSection: Int {
    case createNewChannelSection = 0
    case currentChannelsSection
}

class ChannelListViewController: BaseViewController {
    var newChannelTextField: CustomTextfield?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    @IBOutlet var navScrollGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    var navScrollResetPositionY: CGFloat!
    
    var kMaxScrollVelocity: CGFloat = 65.0
    
    var kContractedHeaderHeight: CGFloat = 70.0
    var kExpandedHeaderHeight: CGFloat!
    
    let kContractedLabelFontSize: CGFloat = 20.0
    var kExpandedLabelFontSize: CGFloat!
    
    var kLargeLogoDistanceMultiplier: CGFloat = 0.1
    
    var channels: [Channel] = []
    
    lazy var channelRef: FIRDatabaseReference = FIRDatabase.database().reference().child("channels")
    var channelRefHandle: FIRDatabaseHandle?

    private func observeChannels() {

        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot) -> Void in
            let channelData = snapshot.value as! Dictionary<String, AnyObject>
            let id = snapshot.key
            if let name = channelData["name"] as! String!, name.characters.count > 0 {
                self.channels.append(Channel(id: id, name: name))
                self.tableView.reloadData()
            } else {
                print("Error! Could not decode channel data")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeChannels()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // toolbar
        let backButton = UIBarButtonItem(image: UIImage(named: "Close-1"), style: .plain, target: self, action: #selector(didTapBackButton(sender:)))
        navigationItem.rightBarButtonItem = backButton
        
        //Scrolling
        navScrollGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleNavScrollGesture))
        navScrollGestureRecognizer.delegate = self
        tableView.addGestureRecognizer(navScrollGestureRecognizer)
    }
    
    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
        }
        
        self.navigationController?.navigationBar.removeGestureRecognizer(navScrollGestureRecognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if kExpandedLabelFontSize == nil {
            kExpandedLabelFontSize = labelView.font.pointSize
        }
        
        if kExpandedHeaderHeight == nil {
            kExpandedHeaderHeight = headerView.frame.height
        }
    }

    
    
    func didTapBackButton(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createChannel(_ sender: AnyObject) {
        if let name = newChannelTextField?.text {
            let newChannelRef = channelRef.childByAutoId()
            let channelItem = [
                "name": name
            ]
            newChannelRef.setValue(channelItem)
        }
    }
}

extension ChannelListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = (indexPath as NSIndexPath).section == ChannelSection.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if (indexPath as NSIndexPath).section == ChannelSection.createNewChannelSection.rawValue {
            if let createNewChannelCell = cell as? CreateChannelCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        } else if (indexPath as NSIndexPath).section == ChannelSection.currentChannelsSection.rawValue {
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
        }
        
        return cell
    }
}

//Table View
extension ChannelListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 2
        if let currentSection: ChannelSection = ChannelSection(rawValue: section) {
            switch currentSection {
            case .createNewChannelSection:
                return 1
            case .currentChannelsSection:
                return channels.count
            }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == ChannelSection.currentChannelsSection.rawValue {
            let channel = channels[(indexPath as NSIndexPath).row]
            self.performSegue(withIdentifier: "ShowChannel", sender: channel)
        }
    }
}

//Navigation
extension ChannelListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let channel = sender as? Channel {
            let chatVc = segue.destination as! ChatViewController
            
            chatVc.channel = channel
            chatVc.channelRef = channelRef.child(channel.id)
            chatVc.senderDisplayName = Injector.currentInjector.memoryCacheDataStore.user.username
        }
    }
}

extension ChannelListViewController : UIGestureRecognizerDelegate {
    func handleNavScrollGesture() {
        
        if navScrollGestureRecognizer.state == .began {
            navScrollResetPositionY = 0
        }
        
        var cappedVelocity = navScrollGestureRecognizer.velocity(in: self.view).y
        if cappedVelocity > kMaxScrollVelocity {
            cappedVelocity = kMaxScrollVelocity
        } else if cappedVelocity < -kMaxScrollVelocity {
            cappedVelocity = -kMaxScrollVelocity
        }
        
        var finalHeaderHeight = headerViewHeightConstraint.constant + cappedVelocity / ((kExpandedHeaderHeight-kContractedHeaderHeight))
        if finalHeaderHeight > kExpandedHeaderHeight {
            finalHeaderHeight = kExpandedHeaderHeight
        } else if finalHeaderHeight < kContractedHeaderHeight {
            finalHeaderHeight = kContractedHeaderHeight
        }
        
        if cappedVelocity < 0 {
            if tableView.contentOffset.y >= 0 && finalHeaderHeight >= kContractedHeaderHeight {
                headerViewHeightConstraint.constant = finalHeaderHeight
            }
        } else if cappedVelocity > 0 {
            if tableView.contentOffset.y <= 0 && finalHeaderHeight <= kExpandedHeaderHeight {
                headerViewHeightConstraint.constant = finalHeaderHeight
            }
        }
        
        var finalFontSize = labelView.font.pointSize + cappedVelocity / (kExpandedLabelFontSize - kContractedLabelFontSize)
        
        if finalFontSize > kExpandedLabelFontSize {
            finalFontSize = kExpandedLabelFontSize
        } else if finalFontSize < kContractedLabelFontSize {
            finalFontSize = kContractedLabelFontSize
        }
        
        if cappedVelocity < 0 {
            if tableView.contentOffset.y >= 0 && finalFontSize >= kContractedLabelFontSize {
                self.labelView.font = UIFont(name: self.labelView.font.fontName, size: finalFontSize)            }
        } else if cappedVelocity > 0 {
            if tableView.contentOffset.y <= 0 && finalFontSize <= kExpandedLabelFontSize {
                self.labelView.font = UIFont(name: self.labelView.font.fontName, size: finalFontSize)
            }
        }
        
        let headerPercentageOffset = (kExpandedHeaderHeight - headerViewHeightConstraint.constant) / (kExpandedHeaderHeight - kContractedHeaderHeight)
        
        if navScrollGestureRecognizer.state == .ended || navScrollGestureRecognizer.state == .cancelled  {
            if (headerPercentageOffset > 0.5 && cappedVelocity > -30 && cappedVelocity < 30) || cappedVelocity < -30 {
                let pixels = min(headerViewHeightConstraint.constant - kContractedHeaderHeight, (labelView.font.pointSize - kContractedHeaderHeight)*kLargeLogoDistanceMultiplier)
                
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: Double(pixels/kMaxScrollVelocity), animations: { [unowned self] in
                    
                    self.labelView.font = UIFont(name: self.labelView.font.fontName, size: self.kContractedLabelFontSize)
                    
                    self.headerViewHeightConstraint.constant = self.kContractedHeaderHeight
                    
                    self.view.layoutIfNeeded()
                })
            } else {
                let pixels = min(kExpandedHeaderHeight - headerViewHeightConstraint.constant, (kExpandedLabelFontSize - labelView.font.pointSize)*kLargeLogoDistanceMultiplier)
                
                self.view.layoutIfNeeded()
                
                UIView.animate(withDuration: Double(pixels/kMaxScrollVelocity), animations: { [unowned self] in
                    
                    self.labelView.font = UIFont(name: self.labelView.font.fontName, size: self.kExpandedLabelFontSize)
                    self.headerViewHeightConstraint.constant = self.kExpandedHeaderHeight
                    
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

