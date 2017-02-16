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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped at \(indexPath.row)")
        

    }

}

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var techTypeTitleLabel: UILabel!
}
