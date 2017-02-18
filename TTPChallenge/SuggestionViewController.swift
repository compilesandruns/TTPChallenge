//
//  SuggestionViewController.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdateTableView, CustomCellPresentAlert {
    
    @IBOutlet weak var suggestionTableView: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
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
        
        cell.isExpanded = !cell.isExpanded
        cell.configureCell()
        tableView.beginUpdates()
        tableView.endUpdates()
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func updateTableView() {
        OperationQueue.main.addOperation {
            
            self.suggestionTableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    func showAlert(meetup: MeetUp) {
        
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




