//
//  SaveContentViewController.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/17/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class SavedContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTableView, RemoveFavorite {
    
    @IBOutlet weak var savedContentTableView: UITableView!
    
    var meetups = [MeetUp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillMeetups()
        savedContentTableView.delegate = self
        savedContentTableView.dataSource = self
        savedContentTableView.rowHeight = UITableViewAutomaticDimension
        savedContentTableView.estimatedRowHeight = 300.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "meetupCell", for: indexPath) as! ExpandingMeetUpCell
        cell.delegate = self
        if indexPath.section == 0{
            let meetup = meetups[indexPath.row]
            cell.meetup = meetup
            meetup.delegate = self
            cell.title.text = cell.meetup.name
            cell.summary.text = cell.isExpanded ? cell.meetup.summary : "Read More"
            cell.summary.textAlignment = cell.isExpanded ? .left : .center
            cell.summary.backgroundColor = cell.isExpanded ? UIColor.white : UIColor(red: 54/255, green: 34/255, blue: 149/255, alpha: 1.0)
            cell.mainImage.image = cell.meetup.image
            cell.starButton?.isSelected = checkIfFavorited(meetup: cell.meetup)
            
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
        return meetups.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        if (section == 0){
            return "    Join a Community"
        }
        if (section == 1){
            return "    Take a Free Course"
        }
        
        return ""
    }
    
    
    func fillMeetups() {
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else{return}
        
        for each in unwrappedFavs{
            
            if let name = each["name"],
                let summary = each["summary"],
                let imageUrl = each["url"],
                let url = each["url"]{
                
                let meetup = MeetUp(name: name as! String, memberCount: 0, summary: summary as! String, imageUrl: imageUrl as! String, url: url as! String)

                meetups.append(meetup)
            }
        }
    }
    
    func checkIfFavorited(meetup: MeetUp) -> Bool {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else{return false}
        
        for each in unwrappedFavs{
            
            let name = each["name"] as! String
            
            if meetup.name == name {
                
                return true
            }
        }
        
        return false
    }
    
    func updateTableView() {
        
        
            self.savedContentTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ExpandingMeetUpCell else { return }
        
        //        if indexPath.section == 0{
        
        let meetup = meetups[indexPath.row]
        
        cell.isExpanded = !cell.isExpanded
        
        cell.summary.text = cell.isExpanded ? meetup.summary : "Read More"
        cell.summary.textAlignment = cell.isExpanded ? .left : .center
        cell.summary.backgroundColor = cell.isExpanded ? UIColor.white : UIColor(red: 54/255, green: 34/255, blue: 149/255, alpha: 1.0)
        cell.summary.textColor = cell.isExpanded ? UIColor.black : UIColor.white
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        //    }
    }
    
    func removeFavorite(name: String) {
        let notEmpty = meetups.isEmpty == false
        
        if notEmpty{
            
            for (index, each) in meetups.enumerated(){
                
                if each.name == name{
                    
                    meetups.remove(at: index)
                    savedContentTableView.reloadData()
                }
            }
        }
        
    }
    
    
}
