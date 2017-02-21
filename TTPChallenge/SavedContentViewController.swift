//
//  SaveContentViewController.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/17/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit
import PKHUD

class SavedContentViewController: BaseViewController, RemoveFavorite {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nothingSavedLabel: UILabel!
    
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
    
    var meetups = [MeetUp]()
    var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillMeetups()
        fillCourses()
        checkForNoFavs()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300.0
        
        labelView.adjustsFontSizeToFitWidth = true
        
        navScrollGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleNavScrollGesture))
        navScrollGestureRecognizer.delegate = self
        tableView.addGestureRecognizer(navScrollGestureRecognizer)
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
    
    func fillMeetups() {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else {
            HUD.hide()
            return }
        
        if unwrappedFavs.count == 0 {
            HUD.hide()
        }
        
        
        for each in unwrappedFavs {
            
            if let name = each["name"] as? String,
                let summary = each["summary"] as? String,
                let url = each["url"] as? String,
                let imageUrl = each["imageURL"] as? String {
                
                let meetup = MeetUp(name: name, memberCount: 0, summary: summary, imageUrl: imageUrl, url: url)
                meetups.append(meetup)
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func fillCourses() {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favCourses") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else {
            HUD.hide()
//            nothingSavedLabel.isHidden = false
            return }
        
        if unwrappedFavs.count == 0 {
            HUD.hide()
//            nothingSavedLabel.isHidden = false
        }
        
        
        for each in unwrappedFavs {

                let course = Course(dictionary: each)
                
                courses.append(course)
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
//            }
        }
       
    }
    
    func checkForNoFavs(){
        
        if courses.count == 0 && meetups.count == 0{
            nothingSavedLabel.isHidden = false
        } else {
            nothingSavedLabel.isHidden = true
        }
    }
    
    func checkIfFavorited(meetup: MeetUp) -> Bool {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else { return false }
        
        for each in unwrappedFavs {
            
            let name = each["name"] as! String
            
            if meetup.name == name {
                
                return true
            }
        }
        
        return false
    }
}

extension SavedContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "meetupCell", for: indexPath) as! ExpandingMeetUpCell
            cell.delegate = self

            let meetup = meetups[indexPath.row]
            cell.meetup = meetup
            meetup.delegate = self
            cell.configureCell()
            cell.delegateAlert = self
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! ExpandingCoursesCell
            
            cell.delegate = self

            let course = courses[indexPath.row]
            cell.course = course
            course.delegate = self
            cell.configureCell()
            cell.delegateAlert = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Join a Community"
            
        default:
            return "Take a Free Course"
            
        }
    }
}

extension SavedContentViewController: UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return meetups.count
        } else if section == 1{
            
            return courses.count
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        header.textLabel?.frame = header.frame
        header.tintColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0 {
            guard let cell = tableView.cellForRow(at: indexPath) as? ExpandingMeetUpCell else { return }
            
            cell.isExpanded = !cell.isExpanded
            cell.configureCell()
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)

        } else if indexPath.section == 1 {
            
            guard let cell = tableView.cellForRow(at: indexPath) as? ExpandingCoursesCell else { return }
            
            cell.isExpanded = !cell.isExpanded
            cell.configureCell()
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func removeFavoriteMeetup(name: String) {
        
        let notEmpty = meetups.isEmpty == false
        
        if notEmpty {
            
            for (index, each) in meetups.enumerated() {
                
                if each.name == name {
                    
                    meetups.remove(at: index)
                    tableView.reloadData()
                }
            }
        }
        checkForNoFavs()
    }
    
    func removeFavoriteCourse(name: String) {
        
        let notEmpty = courses.isEmpty == false
        
        if notEmpty {
            
            for (index, each) in courses.enumerated() {
                
                if each.name == name {
                    
                    courses.remove(at: index)
                    tableView.reloadData()
                }
            }
        }
        checkForNoFavs()
    }

}

extension SavedContentViewController: UpdateTableView {
    
    func updateTableView() {
        HUD.show(.progress)
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
            HUD.hide()
        }
    }
}

extension SavedContentViewController: CustomCellPresentAlert {
    func showAlert(urlString: String) {
        let _ = showDecisionAlert(message:  "You're about to leave.", title: "See You Later", okButtonTitle: "Ok", cancelButtonTitle: "Cancel").then { (success) -> Bool in
            
            if success{
                UIApplication.shared.open(URL(string: urlString)!, options: [:]) { (success) in
                    
                }
            }
            return true
        }

    }
}

extension SavedContentViewController : UIGestureRecognizerDelegate {
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
