//
//  QuizPartOneVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class QuizVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var objectsArray = [QuizGroup]()
    
    var qa = [false, false, false, false]
    var it = [false, false, false, false]
    var wd = [false, false, false, false]
    var md = [false, false, false, false]
    var da = [false, false, false, false]
    
    let techJobs = [
        "Quality Assurance Analyst",
        "IT Engineer",
        "Web Developer",
        "Mobile Developer",
        "Data Analyst"
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
        super.viewDidLoad()
        
        for data in personalityData {
            
            var newQuestions: [Question] = []
            
            for string in data {
                newQuestions.append(Question(string: string))
            }
            allQuestions.append(newQuestions)
        }
        
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
        
        cell.tapActionForYes = { (cell) in
            self.yesForEachTechType(section: indexPath.section, row: indexPath.row)
        }
        
        cell.tapActionForNo = { (cell) in
            self.noForEachTechType(section: indexPath.section, row: indexPath.row)
        }
        
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
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        
        let qaCount = qa.filter{$0}.count
        let itCount = it.filter{$0}.count
        let wdCount = wd.filter{$0}.count
        let mdCount = md.filter{$0}.count
        let daCount = da.filter{$0}.count
        
        
        
        
        
        // logic here - based on the results, it will segue to a different tech type
        // algo needed
        performSegue(withIdentifier: "resultToWD", sender: self)
        /*
         performSegue(withIdentifier: "resultToDA", sender: self)
         performSegue(withIdentifier: "resultToWD", sender: self)
         performSegue(withIdentifier: "resultToAll", sender: self)
         performSegue(withIdentifier: "resultToMD", sender: self)
         performSegue(withIdentifier: "resultToQA", sender: self)
         
         */
    }
    
    
    func yesForEachTechType(section: Int, row: Int){
        
        switch section {
        case 0:
            print("Quality Assurance Analyst")
            switch row {
            case 0:
                qa[0] = true
            case 1:
                qa[1] = true
            case 2:
                qa[2] = true
            case 3:
                qa[3] = true
            case 4:
                qa[4] = true
            default:
                break
            }
        case 1:
            print("IT Engineer")
            switch row {
            case 0:
                it[0] = true
            case 1:
                it[1] = true
            case 2:
                it[2] = true
            case 3:
                it[3] = true
            case 4:
                it[4] = true
            default:
                break
            }
        case 2:
            print("Web Developer")
            switch row {
            case 0:
                wd[0] = true
            case 1:
                wd[1] = true
            case 2:
                wd[2] = true
            case 3:
                wd[3] = true
            case 4:
                wd[4] = true
            default:
                break
            }
        case 3:
            print("Mobile Developer")
            switch row {
            case 0:
                md[0] = true
            case 1:
                md[1] = true
            case 2:
                md[2] = true
            case 3:
                md[3] = true
            case 4:
                md[4] = true
            default:
                break
            }
        case 4:
            print("Data Analyst")
            switch row {
            case 0:
                da[0] = true
            case 1:
                da[1] = true
            case 2:
                da[2] = true
            case 3:
                da[3] = true
            case 4:
                da[4] = true
            default:
                break
            }
        default:
            break
        }
        print("\n\(qa)\n\(it)\n\(wd)\n\(md)\n\(da)")
        
    }
    
    
    func noForEachTechType(section: Int, row: Int){
        
        switch section {
        case 0:
            print("Quality Assurance Analyst")
            switch row {
            case 0:
                qa[0] = false
            case 1:
                qa[1] = false
            case 2:
                qa[2] = false
            case 3:
                qa[3] = false
            case 4:
                qa[4] = false
            default:
                break
            }
        case 1:
            print("IT Engineer")
            switch row {
            case 0:
                it[0] = false
            case 1:
                it[1] = false
            case 2:
                it[2] = false
            case 3:
                it[3] = false
            case 4:
                it[4] = false
            default:
                break
            }
        case 2:
            print("Web Developer")
            switch row {
            case 0:
                wd[0] = false
            case 1:
                wd[1] = false
            case 2:
                wd[2] = false
            case 3:
                wd[3] = false
            case 4:
                wd[4] = false
            default:
                break
            }
        case 3:
            print("Mobile Developer")
            switch row {
            case 0:
                md[0] = false
            case 1:
                md[1] = false
            case 2:
                md[2] = false
            case 3:
                md[3] = false
            case 4:
                md[4] = false
            default:
                break
            }
        case 4:
            print("Data Analyst")
            switch row {
            case 0:
                da[0] = false
            case 1:
                da[1] = false
            case 2:
                da[2] = false
            case 3:
                da[3] = false
            case 4:
                da[4] = false
            default:
                break
            }
        default:
            break
        }
        print("\n\(qa)\n\(it)\n\(wd)\n\(md)\n\(da)")
    }
    
}
