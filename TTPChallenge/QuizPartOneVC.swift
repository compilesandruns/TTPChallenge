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
    var questions : [Question]
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
    
    var allQuestions: [[Question]] = []
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        
        
        for data in personalityData {
            
            var newQuestions: [Question] = []
            
            for string in data {
                
                newQuestions.append(Question(string: string))
                
            }
            
            allQuestions.append(newQuestions)
            
            
        }
        
        super.viewDidLoad()
        tableView.separatorStyle = .none
        nextButton.layer.cornerRadius = 20
        for i in 0..<5 {
            
            let quizObject = QuizGroup(sectionName: techJobs[i], questions: allQuestions[i], isYes: false)
            
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
        cell.selectionStyle = .none
        cell.personalityView.layer.cornerRadius = 4
        cell.personalityView.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let personalityCell = cell as! PersonalityTestCell
        let question = objectsArray[indexPath.section].questions[indexPath.row]
        personalityCell.question = question
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

    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var personalityView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    
    var tapActionForYes: ((UITableViewCell) -> Void)?
    var tapActionForNo: ((UITableViewCell) -> Void)?
    var yesSelected: Bool = false
    var noSelected: Bool = false
    
    weak var question: Question! {
        didSet {
            questionLabel.text = question.string
            
            if question.selectedYes {
                yesButton.isSelected = true
            }
            
            if question.selectedNo {
                noButton.isSelected = true
            }
        }
    }
    
    func reset() {
        yesButton.isSelected = false
        noButton.isSelected = false
    }

    @IBAction func yesTapped(_ sender: UIButton) {
        question.changeToYes()
        yesButton.isSelected = true
    }
    @IBAction func noTapped(_ sender: Any) {
        question.changeToNo()
        noButton.isSelected = true
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
}

final class Question {
    
    let string: String
    var selectedYes: Bool = false
    var selectedNo: Bool = false
    
    init(string: String) {
        self.string = string
    }
    
    func changeToYes() {
        selectedNo = false
        selectedYes = true
    }
    
    func changeToNo() {
        selectedNo = true
        selectedYes = false
    }
    
}
