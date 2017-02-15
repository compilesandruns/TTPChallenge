//
//  SuggestionViewController.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var suggestionTableView: UITableView!
    var meetups = [MeetUp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestionTableView.delegate = self
        suggestionTableView.dataSource = self
        
        MeetUpAPIClient.getMeetupSuggestions(query: "women") {meetupResults in
            
            for each in meetupResults{
                
                let name = each["name"] as? String
                let count = each ["members"] as? Int
                let summary = each["description"] as? String
                
                if let name = name,
                    let count = count,
                    let summary = summary{
                    
                    let meetup = MeetUp(name: name, memberCount: count, summary: summary)
                    self.meetups.append(meetup)
                    OperationQueue.main.addOperation {
                        self.suggestionTableView.reloadData()
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "meetupCell", for: indexPath) as! ExpandingMeetUpCell
        
        if indexPath.section == 0{
            cell.title.text = meetups[indexPath.row].name
            cell.summary.text = meetups[indexPath.row].summary
            cell.memberCount.text = String(meetups[indexPath.row].memberCount)
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
        
        let cell = tableView.cellForRow(at: indexPath) as! ExpandingMeetUpCell
        
//        if cell.isExpanded{
//            
//            
//            
//        } else {
//            
//
//        }
    }
}









