//
//  QuizQuestions.swift
//  TTPChallenge
//
//  Created by Mirim An on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

struct Quiz {
    
    var question : String
    var isYes = false
    
}

class QuizQuestions: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var objectsArray = [Quiz]()
    
    @IBOutlet weak var tableView: UITableView!
    
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
         "Have strong preferences for specific technology or apps"],
        ["Able to work across teams and with a variety of stakeholders",
         "Communicate effectively and build strong relationships with team members",
         "Have a knack for math, facts and figures",
         "Love simplifying complex ideas"]
    ]
    
    let questions =  [
        
    "Enjoy trying out new products",
    "Stay up to date on the latest and greatest in tech and devices",
    "Want to get involved in tech, but not sure where to start",
     "Enjoy puzzles and challenges",
    "Enjoy tinkering with computers and devices",
    "Are curious about how tech products work",
    "Enjoy fast-paced work",
    "Enjoy solving problems",
    "Have a creative spirit",
    "Love following the latest web trends & technologies",
    "Think logically and critically",
    "Have tried or are interested in learning how to code",
    "Are iPhone or Android obsessed",
    "Are Always on the hunt for the latest cool app",
    "Enjoy learning about new technology",
    "Have strong preferences for specific technology or apps",
    "Able to work across teams and with a variety of stakeholders",
    "Communicate effectively and build strong relationships with team members",
    "Have a knack for math, facts and figures",
    "Love simplifying complex ideas"
        
    ]

    let answers = ["Yes", "No"]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        for i in 0..<5 {
            for x in 0..<4{
            let quizObject = Quiz(question: personalityData[i][x], isYes: true)
            objectsArray.append(quizObject)
            
            }
        }
            
        tableView.allowsMultipleSelection = true
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "partTwoCell", for: indexPath)
        cell.textLabel?.text = answers[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.font = UIFont(name: "System", size: 10)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(questions.count)
        return questions.count
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].question
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    
            let selectedIndexPaths = indexPathsForSelectedRowsInSection(section: indexPath.section)
    
            if selectedIndexPaths?.count == 1 {
                tableView.deselectRow(at: selectedIndexPaths!.first! as IndexPath, animated: false)
            }
    
            return indexPath
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = objectsArray[section].question
        return label
    }
    
    func indexPathsForSelectedRowsInSection(section: Int) -> [IndexPath]? {
        return (tableView.indexPathsForSelectedRows)?.filter({ (indexPath) -> Bool in
            indexPath.section == section
        })
    }
    
}

