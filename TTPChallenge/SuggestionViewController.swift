//
//  SuggestionViewController.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit
import PKHUD

class SuggestionViewController: BaseViewController {
    
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
    
    
    let store = DataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300.0
        
        labelView.adjustsFontSizeToFitWidth = true
        
        navScrollGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleNavScrollGesture))
        navScrollGestureRecognizer.delegate = self
        tableView.addGestureRecognizer(navScrollGestureRecognizer)
        
        store.fillMeetupStore { (success) in
            if success {
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    deinit {
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
}

extension SuggestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ExpandingMeetUpCell else { return }
        
        cell.isExpanded = !cell.isExpanded
        cell.configureCell()
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
}

extension SuggestionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "meetupCell", for: indexPath) as! ExpandingMeetUpCell
        
        switch indexPath.section {
            
        case 0:
            let meetup = store.meetups[indexPath.row]
            cell.meetup = meetup
            meetup.delegate = self
            cell.configureCell()
            cell.delegateAlert = self
            
        default:
            
            cell.title.text = "not a meetup"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return store.meetups.count
            
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Join a Community"
            
        default:
            return "Take a Free Course"
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        header.textLabel?.frame = header.frame
        header.tintColor = UIColor.white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
}

extension SuggestionViewController : UpdateTableView {
    func updateTableView() {
        HUD.show(.progress)
        OperationQueue.main.addOperation {
            
            self.tableView.reloadData()
            HUD.hide()
        }
    }
}

extension SuggestionViewController: CustomCellPresentAlert {
    func showAlert(meetup: MeetUp) {
        
        let _ = showDecisionAlert(message:  "You're about to leave.", title: "See You Later", okButtonTitle: "Ok", cancelButtonTitle: "Cancel").then { (success) -> Bool in
            
            if success{
                UIApplication.shared.open(URL(string: meetup.url)!, options: [:]) { (success) in
                    
                }
            }
            return true
        }
    }
}

extension SuggestionViewController : UIGestureRecognizerDelegate {
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
