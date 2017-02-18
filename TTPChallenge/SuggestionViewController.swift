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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var meetups = [MeetUp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestionTableView.delegate = self
        suggestionTableView.dataSource = self
        suggestionTableView.rowHeight = UITableViewAutomaticDimension
        suggestionTableView.estimatedRowHeight = 300.0
        
        MeetUpAPIClient.getMeetupSuggestions(query: "women") {meetupResults in
            
            for each in meetupResults{
                print(each)
                let name = each["name"] as? String
                let count = each ["members"] as? Int
                let summary = each["description"] as? String
                let photo = each["key_photo"] as? [String : Any]
                let url = each["link"] as? String
                if let photo = photo,
                    let name = name,
                    let count = count,
                    let summary = summary,
                    let url = url{
                    
                    let photoURL = photo["photo_link"] as? String
                    if let photoURL = photoURL {
                        
                        let meetup = MeetUp(name: name, memberCount: count, summary: summary, imageUrl: photoURL, url: url)
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
            
            cell.meetup = meetup
            meetup.delegate = self
            cell.title.text = cell.meetup.name
            cell.summary.text = cell.isExpanded ? cell.meetup.summary : "Read More"
            cell.summary.textAlignment = cell.isExpanded ? .left : .center
            cell.summary.backgroundColor = cell.isExpanded ? UIColor.white : UIColor(red: 54/255, green: 34/255, blue: 149/255, alpha: 1.0)
            cell.mainImage.image = cell.meetup.image
            cell.starButton?.isSelected = checkIfFavorited(meetup: cell.meetup)
//            cell.joinbutton?.isSelected = checkIfJoined(meetup: cell.meetup)
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
            return "Join a Community"
        }
        if (section == 1){
            return "Take a Free Course"
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
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
    
    func updateTableView() {
        OperationQueue.main.addOperation {
            
            self.suggestionTableView.reloadData()
        }
        self.spinner.stopAnimating()
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
}




