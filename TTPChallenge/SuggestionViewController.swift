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
                if let photo = photo,
                    let name = name,
                    let count = count,
                    let summary = summary{
                    
                    let photoURL = photo["highres_link"] as? String
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

            if cell.starButton == nil{
                addFavButton(cell: cell, tag: indexPath.row)
            }
            
         cell.contentView.addSubview(cell.starButton!)
            
            
            
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
            return "    Join a Community"
        }
        if (section == 1){
            return "    Take a Free Course"
        }
        
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ExpandingMeetUpCell else { return }
        
        if indexPath.section == 0{
            
            let meetup = meetups[indexPath.row]
            
            cell.isExpanded = !cell.isExpanded
            
            cell.summary.text = cell.isExpanded ? meetup.summary : "Read More"
            cell.summary.textAlignment = cell.isExpanded ? .left : .center
            cell.summary.backgroundColor = cell.isExpanded ? UIColor.white : UIColor.lightGray
            cell.summary.textColor = cell.isExpanded ? UIColor.black : UIColor.white
            tableView.beginUpdates()
            tableView.endUpdates()
            
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func updateTableView() {
        
        suggestionTableView.reloadData()
        
    }
    
    func addFavButton(cell: ExpandingMeetUpCell, tag: Int){
        
        let x = cell.mainImage.frame.origin.x
        let y = cell.mainImage.frame.origin.y
        
        cell.starButton = DOFavoriteButton(frame: CGRect(x: x, y: y, width: 44, height: 44), image: UIImage(named: "star"))
        
        cell.starButton!.addTarget(self, action: #selector(favBtnTouched(sender:)), for: .touchUpInside)
        cell.contentView.addSubview(cell.starButton!)
    }
    
    func favBtnTouched(sender: UIButton) {
        
        let expSender = sender as! DOFavoriteButton
        
        if sender.isSelected {
            expSender.deselect()
        } else {
            expSender.select()
        }
    }
}









