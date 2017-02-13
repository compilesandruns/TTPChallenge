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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        suggestionTableView.delegate = self
        suggestionTableView.dataSource = self
        
        MeetUpAPIClient.getMeetupSuggestions(query: "tech") {
            //nothing yet
            
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "hi"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
    
}
