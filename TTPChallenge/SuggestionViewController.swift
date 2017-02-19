//
//  SuggestionViewController.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class SuggestionViewController: BaseViewController {
    
    @IBOutlet weak var suggestionTableView: UITableView!
    @IBOutlet var navScrollGestureRecognizer: UIPanGestureRecognizer!
    
    let store = DataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestionTableView.delegate = self
        suggestionTableView.dataSource = self
        suggestionTableView.rowHeight = UITableViewAutomaticDimension
        suggestionTableView.estimatedRowHeight = 300.0
        
        store.fillMeetupStore { (success) in
            if success {
                OperationQueue.main.addOperation {
                    self.suggestionTableView.reloadData()
                }
            }
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
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        header.textLabel?.frame = header.frame
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
}

extension SuggestionViewController : UpdateTableView {
    func updateTableView() {
        OperationQueue.main.addOperation {
            
            self.suggestionTableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
}

extension SuggestionViewController: CustomCellPresentAlert {
    func showAlert(meetup: MeetUp) {
        showDecisionAlert(message:  "You're about to leave.", title: "See You Later", okButtonTitle: "Ok", cancelButtonTitle: "Cancel")
    }
}

extension SuggestionViewController : UIGestureRecognizerDelegate {
    func handleNavScrollGesture() {
        
        if navScrollGestureRecognizer.state == .Began {
            navScrollResetPositionY = 0
        }
        
        var cappedVelocity = navScrollGestureRecognizer.velocityInView(self.view).y
        if cappedVelocity > kMaxScrollVelocity {
            cappedVelocity = kMaxScrollVelocity
        } else if cappedVelocity < -kMaxScrollVelocity {
            cappedVelocity = -kMaxScrollVelocity
        }
        
        var finalPlanHeaderHeight = planHeaderViewHeightConstraint.constant + cappedVelocity / ((kExpandedHeaderHeight-kContractedHeaderHeight))
        if finalPlanHeaderHeight > kExpandedHeaderHeight {
            finalPlanHeaderHeight = kExpandedHeaderHeight
        } else if finalPlanHeaderHeight < kContractedHeaderHeight {
            finalPlanHeaderHeight = kContractedHeaderHeight
        }
        
        if cappedVelocity < 0 {
            if tableView.contentOffset.y >= 0 && finalPlanHeaderHeight >= kContractedHeaderHeight {
                planHeaderViewHeightConstraint.constant = finalPlanHeaderHeight
            }
        } else if cappedVelocity > 0 {
            if tableView.contentOffset.y <= 0 && finalPlanHeaderHeight <= kExpandedHeaderHeight {
                planHeaderViewHeightConstraint.constant = finalPlanHeaderHeight
            }
        }
        
        var finalLargeLogoHeight = largeLogoViewHeightConstraint.constant + cappedVelocity / ((kExpandedLogoHeight-kContractedLogoHeight)*kLargeLogoDistanceMultiplier)
        
        if finalLargeLogoHeight > kExpandedLogoHeight {
            finalLargeLogoHeight = kExpandedLogoHeight
        } else if finalLargeLogoHeight < kContractedLogoHeight {
            finalLargeLogoHeight = kContractedLogoHeight
        }
        
        if cappedVelocity < 0 {
            if tableView.contentOffset.y >= 0 && finalLargeLogoHeight >= kContractedLogoHeight {
                largeLogoViewHeightConstraint.constant = finalLargeLogoHeight
            }
        } else if cappedVelocity > 0 {
            if tableView.contentOffset.y <= 0 && finalLargeLogoHeight <= kExpandedLogoHeight {
                largeLogoViewHeightConstraint.constant = finalLargeLogoHeight
            }
        }
        
        let headerPercentageOffset = (kExpandedHeaderHeight - planHeaderViewHeightConstraint.constant) / (kExpandedHeaderHeight - kContractedHeaderHeight)
        
        if headerPercentageOffset >= 0.999 {
            largeMembershipIdLabel.alpha = 1
            memberNumberStringLabel.alpha = 0
            membershipIdLabel.alpha = 0
            planNameLabel.alpha = 0
        } else if headerPercentageOffset <= 0.001 {
            largeMembershipIdLabel.alpha = 0
            memberNumberStringLabel.alpha = 1
            membershipIdLabel.alpha = 1
            planNameLabel.alpha = 1
        } else {
            
            if headerPercentageOffset > 0.5 {
                largeMembershipIdLabel.alpha = (2 * CGFloat(headerPercentageOffset)) - 1
            } else {
                memberNumberStringLabel.alpha = 1 - (2 * CGFloat(headerPercentageOffset))
                membershipIdLabel.alpha = 1 - (2 * CGFloat(headerPercentageOffset))
                planNameLabel.alpha = 1 - (2 * CGFloat(headerPercentageOffset))
            }
        }
        
        if navScrollGestureRecognizer.state == .Ended || navScrollGestureRecognizer.state == .Cancelled  {
            if (headerPercentageOffset > 0.5 && cappedVelocity > -30 && cappedVelocity < 30) || cappedVelocity < -30 {
                let pixels = min(planHeaderViewHeightConstraint.constant - kContractedHeaderHeight, (largeLogoViewHeightConstraint.constant - kContractedHeaderHeight)*kLargeLogoDistanceMultiplier)
                
                self.view.layoutIfNeeded()
                
                UIView.animateWithDuration(Double(pixels/kMaxScrollVelocity), animations: { [unowned self] in
                    self.largeMembershipIdLabel.alpha = 1
                    self.memberNumberStringLabel.alpha = 0
                    self.membershipIdLabel.alpha = 0
                    self.planNameLabel.alpha = 0
                    
                    self.largeLogoViewHeightConstraint.constant = self.kContractedLogoHeight
                    self.planHeaderViewHeightConstraint.constant = self.kContractedHeaderHeight
                    
                    self.view.layoutIfNeeded()
                })
            } else {
                let pixels = min(kExpandedHeaderHeight - planHeaderViewHeightConstraint.constant, (kExpandedLogoHeight - largeLogoViewHeightConstraint.constant)*kLargeLogoDistanceMultiplier)
                
                self.view.layoutIfNeeded()
                
                UIView.animateWithDuration(Double(pixels/kMaxScrollVelocity), animations: { [unowned self] in
                    self.largeMembershipIdLabel.alpha = 0
                    self.memberNumberStringLabel.alpha = 1
                    self.membershipIdLabel.alpha = 1
                    self.planNameLabel.alpha = 1
                    
                    self.largeLogoViewHeightConstraint.constant = self.kExpandedLogoHeight
                    self.planHeaderViewHeightConstraint.constant = self.kExpandedHeaderHeight
                    
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
