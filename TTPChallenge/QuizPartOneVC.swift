//
//  QuizPartOneVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

struct QuizGroup {
    
    var sectionName : String
    var questions : [String]
    var isYes = false
    
}

class QuizPartOneVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var objectsArray = [QuizGroup]()
    
    let techJobs = [
        "Quality Assurance Analyst","IT Engineer","Web Developer","Mobile Developer","Data Analyst"
    ]
    
    let personalityData = [
        
        ["Enjoy trying out new products",
         "Stay up to date on the latest and greatest in tech and devices",
         "Want to get involved in tech, but not sure where to start",
         "Enjoy puzzles and challenges"],
        ["Enjoy tinkering with computers and devices",
         "Are curious about how tech products work",
         "Enjoy fast-paced work",
         "Enjoy solving problems"],
        ["Have a creative spirit",
        "Love following the latest web trends & technologies",
        "Think logically and critically",
        "Have tried or are interested in learning how to code"],
        ["Are iPhone or Android obsessed",
         "Are Always on the hunt for the latest cool app",
        "Enjoy learning about new technology",
        "Have strong preferences for specific technology or apps",
        "Have tried or areinterested in learning how to code"],
        ["Able to work across teams and with a variety of stakeholders",
        "Communicate effectively and build strong relationships with team members",
        "Have a knack for math, facts and figures",
        "Love simplifying complex ideas"]
    ]
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.separatorStyle = .none
        nextButton.layer.cornerRadius = 20
        for i in 0..<5 {
            let quizObject = QuizGroup(sectionName: techJobs[i], questions: personalityData[i], isYes: false)
            objectsArray.append(quizObject)
        }
     
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // Tableview methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return techJobs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "personalityCell", for: indexPath) as! PersonalityTestCell
        
        cell.questionLabel.text = objectsArray[indexPath.section].questions[indexPath.row]
        cell.selectionStyle = .none
        
        // personalityView styling
        cell.personalityView.layer.cornerRadius = 4
        cell.personalityView.layer.masksToBounds = true
       
        // Button tag
        
        for (index, button) in cell.buttons.enumerated() {
            
            if index == button.tag && index == 0 {
                cell.tapActionForYes = { (cell) in
                    self.yesButtonTapped(cell: cell as! PersonalityTestCell, section: indexPath.section, indexPath.row)
                }} else {
                cell.tapActionForNo = { (cell) in
                    self.noButtonTapped(cell: cell as! PersonalityTestCell, section: indexPath.section, indexPath.row)
                }

            }
            
        }
        return cell
    }
    
    
    func yesButtonTapped(cell: PersonalityTestCell, section: Int, _ row: Int) {
        
        print("YES")
    }
    
    func noButtonTapped(cell: PersonalityTestCell, section: Int, _ row: Int) {
        
        print("NO!")
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Making the section header invisible
        return 0
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}

class PersonalityTestCell: UITableViewCell {
    
    var tapActionForYes: ((UITableViewCell) -> Void)?
    var tapActionForNo: ((UITableViewCell) -> Void)?
    
    @IBOutlet weak var personalityView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var noLabel: UILabel!
    
    @IBAction func yesTapped(_ sender: UIButton) {
        tapActionForYes?(self)
        buttons[0].isSelected = true
        buttons[1].isSelected = false
    }
    @IBAction func noTapped(_ sender: Any) {
        tapActionForNo?(self)
        buttons[0].isSelected = false
        buttons[1].isSelected = true
    }
    
}
