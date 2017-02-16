//
//  SuggestionViewController.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTableView {
    
    @IBOutlet weak var suggestionTableView: UITableView!
    
//    @IBOutlet weak var suggestionTableView: UITableView!
    
    var meetups = [MeetUp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestionTableView.delegate = self
        suggestionTableView.dataSource = self
        suggestionTableView.rowHeight = UITableViewAutomaticDimension
        suggestionTableView.estimatedRowHeight = 300.0
        
        MeetUpAPIClient.getMeetupSuggestions(query: "women") {meetupResults in
            
            for each in meetupResults{
                
                let name = each["name"] as? String
                let count = each ["members"] as? Int
                let summary = each["description"] as? String
                let photo = each["key_photo"] as? [String : Any]
                print(each)
                if let photo = photo,
                    let name = name,
                    let count = count,
                    let summary = summary{
                    
                    let photoURL = photo["highres_link"] as? String
//                    print(photoURL)
                    if let photoURL = photoURL {
                        
                        let meetup = MeetUp(name: name, memberCount: count, summary: summary, urlString: photoURL)
                        self.meetups.append(meetup)
                        OperationQueue.main.addOperation {
                            self.suggestionTableView.reloadData()
                        }
                        
                    }
                    
                }
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "meetupCell", for: indexPath) as! ExpandingMeetUpCell
        
        if indexPath.section == 0{
            let meetup = meetups[indexPath.row]
            meetup.delegate = self
            cell.title.text = meetup.name
            cell.summary.text = cell.isExpanded ? meetup.summary : "Read More"
            cell.summary.textAlignment = cell.isExpanded ? .left : .center
            cell.summary.backgroundColor = cell.isExpanded ? UIColor.white : UIColor.lightGray
            cell.mainImage.image = meetup.image
            cell.selectionStyle = .none
            
            } else {
            
            cell.title.text = "not a meetup"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return meetups.count
            
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        if (section == 0){
            return "Join a Community"
        }
        if (section == 1){
            return "Take a Free Course"
        }
        
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 1
        guard let cell = tableView.cellForRow(at: indexPath) as? ExpandingMeetUpCell else { return }
        
        if indexPath.section == 0{
            
        let meetup = meetups[indexPath.row]
        
        // 2
        cell.isExpanded = !cell.isExpanded
        meetups[indexPath.row] = meetup
        
        // 3
        cell.summary.text = cell.isExpanded ? meetup.summary : "Read More"
        cell.summary.textAlignment = cell.isExpanded ? .left : .center
        
        // 4
        tableView.beginUpdates()
        tableView.endUpdates()
        
        // 5
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func updateTableView() {
        
        suggestionTableView.reloadData()
    }
}









