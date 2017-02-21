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

class ChannelListViewController: BaseTableViewController {
    var newChannelTextField: UITextField?
    
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
        title = "Tech Talk"
        observeChannels()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(didTapBackButton(sender:)))
        
        navigationItem.rightBarButtonItem = backButton
    }
    
    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
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


//Table View
extension ChannelListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // 2
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
