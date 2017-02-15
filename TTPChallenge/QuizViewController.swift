//
//  QuizzViewController.swift
//  TTPChallenge
//
//  Created by Mirim An on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var isYes = false
    
    let personalityData = [
        
        "Enjoy trying out new products", "Stay up to date on the latest and greatest in tech and devices","Want to get involved in tech, but not sure where to start", "Enjoy puzzles and challenges", "Enjoy tinkering with computers and devices","Are curious about how tech products work", "Enjoy fast-paced work", "Enjoy solving problems", "Have a creative spirit",
        "Love following the latest web trends & technologies",
        "Think logically and critically",
        "Have tried or are interested in learning how to code", "Are iPhone or Android obsessed", "Are Always on the hunt for the latest cool app",
        "Enjoy learning about new technology",
        "Have strong preferences for specific technology or apps",
        "Have tried or areinterested in learning how to code", "Able to work across teams and with a variety of stakeholders",
        "Communicate effectively and build strong relationships with team members",
        "Have a knack for math, facts and figures",
        "Love simplifying complex ideas"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        nextButton.layer.cornerRadius = 20
        progressBar.layer.cornerRadius = 10
        progressBar.layer.masksToBounds = true
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        print("Next!")
        
    }
    // Tableview Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizCell
        
        cell.quizLabel.text = personalityData[indexPath.row]
        cell.selectionStyle = .none
        cell.buttonView.layer.cornerRadius = 10
        cell.progressLabel.text = " \(indexPath.row + 1)/20"
       
        return cell
    }
    
}

class QuizCell: UITableViewCell {
    
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var progressLabel: UILabel!
   
    
    
}
