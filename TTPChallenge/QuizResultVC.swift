//
//  QuizResultVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/16/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class QuizResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var techTypesFromResults:[String]?
    var indexArrayPassed: [Int]?
    
    let techJobs = [
        "Quality Assurance Analyst",
        "IT Engineer",
        "Web Developer",
        "Mobile Developer",
        "Data Analyst"
    ]
    
    let colors = [Colors.qaPeach, Colors.itPink, Colors.wdRose, Colors.mdBlue, Colors.daGreen]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let techTypes = techTypesFromResults {
            return techTypes.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! ResultCell
        if let techTypes = techTypesFromResults {
             cell.techTypeTitleLabel.text = techTypes[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = colors[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let types = techTypesFromResults {
            for (i,job) in techJobs.enumerated() {
                if types[indexPath.row] == job {
                    performSegue(withIdentifier: "segueTo\(i)", sender: self)
                }
            }
        }
    }
    
    @IBAction func retakeQuizBtnTapped(_ sender: Any) {
        let id = "backHome"
        performSegue(withIdentifier: id, sender: self)
    }
}

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var techTypeTitleLabel: UILabel!
}
