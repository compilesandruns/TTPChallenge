//
//  SaveContentViewController.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/17/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class SavedContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTableView, RemoveFavorite,CustomCellPresentAlert {
    
    @IBOutlet weak var savedContentTableView: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var nothingSavedLabel: UILabel!
    
    var meetups = [MeetUp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillMeetups()
        savedContentTableView.delegate = self
        savedContentTableView.dataSource = self
        savedContentTableView.rowHeight = UITableViewAutomaticDimension
        savedContentTableView.estimatedRowHeight = 300.0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "meetupCell", for: indexPath) as! ExpandingMeetUpCell
        cell.delegate = self
        
        if indexPath.section == 0{
            let meetup = meetups[indexPath.row]
            cell.meetup = meetup
            meetup.delegate = self
            cell.configureCell()
            cell.delegateAlert = self
            
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        header.textLabel?.frame = header.frame
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        switch section {
        case 0:
            return "Join a Community"
            
        default:
            return "Take a Free Course"
            
        }
    }
    
    func fillMeetups() {
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else{return}
        
        if favs?.count == 0{
            spinner.stopAnimating()
            nothingSavedLabel.isHidden = false
            return
        }
        
        for each in unwrappedFavs{
            
            if let name = each["name"] as? String,
                let summary = each["summary"] as? String,
                let url = each["url"] as? String,
                let imageUrl = each["imageURL"] as? String{
                
                let meetup = MeetUp(name: name, memberCount: 0, summary: summary, imageUrl: imageUrl, url: url)
                meetups.append(meetup)
                
                OperationQueue.main.addOperation {
                    self.savedContentTableView.reloadData()
                }
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
        
        OperationQueue.main.addOperation {
            self.spinner.stopAnimating()
            self.savedContentTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ExpandingMeetUpCell else { return }
        
        cell.isExpanded = !cell.isExpanded
        cell.configureCell()
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
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
        
        nothingSavedLabel.isHidden = meetups.count > 0
    }
    
    func showAlert(meetup: MeetUp){
        
        let alertController = UIAlertController(title: "See You Later", message: "You're about to leave.", preferredStyle: UIAlertControllerStyle.alert)
        
        let DestructiveAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive) {
            (result : UIAlertAction) -> Void in
            
        }
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
            UIApplication.shared.open(URL(string: meetup.url)!, options: [:]) { (success) in
                
            }
        }
        
        alertController.addAction(DestructiveAction)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
