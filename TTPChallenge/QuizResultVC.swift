//
//  QuizResultVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/16/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class QuizResultVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var retakeQuizButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var techTypesFromResults:[String]?
    var indexArrayPassed: [Int]?
    
    let colors = [Colors.qaPeach, Colors.itPink, Colors.wdRose, Colors.mdBlue, Colors.daGreen]
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.resultCell) as! ResultCell
        if let techTypes = techTypesFromResults {
             cell.techTypeTitleLabel.text = techTypes[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let resultCell = cell as! ResultCell
        resultCell.backgroundColor = colors[indexPath.row]
        resultCell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let types = techTypesFromResults {
            for (i,job) in Quizzes.techJobs.enumerated() {
                if types[indexPath.row] == job {
                    performSegue(withIdentifier: "segueTo\(i)", sender: self)
                }
            }
        }
    }
    
    @IBAction func retakeQuizBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: Identifier.Segue.backHome, sender: self)
    }
}

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var techTypeTitleLabel: UILabel!
}
