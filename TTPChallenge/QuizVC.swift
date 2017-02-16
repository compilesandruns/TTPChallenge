//
//  QuizPartOneVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class QuizVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var objectsArray: [QuizGroup] = []
    var allQuestions: [[Question]] = []
    var respondedQuestions = 0
    
    var qa = [String]()
    var it = [String]()
    var wd = [String]()
    var md = [String]()
    var da = [String]()
    
    let techJobs = [
        "Quality Assurance Analyst",
        "IT Engineer",
        "Web Developer",
        "Mobile Developer",
        "Data Analyst"
    ]
    
    let personalityData = [
        
        //QA
        ["Enjoy trying out new products",
         "Stay up to date on the latest and greatest in tech and devices",
         "Want to get involved in tech, but not sure where to start",
         "Enjoy puzzles and challenges"],
        //IT
        ["Enjoy tinkering with computers and devices",
         "Are curious about how tech products work",
         "Enjoy fast-paced work",
         "Enjoy solving problems"],
        //WD
        ["Have a creative spirit",
         "Love following the latest web trends & technologies",
         "Think logically and critically",
         "Have tried or are interested in learning how to code"],
        //MD
        ["Are iPhone or Android obsessed",
         "Are Always on the hunt for the latest cool app",
         "Have strong preferences for specific technology or apps",
         "Have tried or areinterested in learning how to code"],
        //DA
        ["Able to work across teams and with a variety of stakeholders",
         "Communicate effectively and build strong relationships with team members",
         "Have a knack for math, facts and figures",
         "Love simplifying complex ideas"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...4 {
            let emptyStr = ""
            qa.append(emptyStr)
            it.append(emptyStr)
            wd.append(emptyStr)
            md.append(emptyStr)
            da.append(emptyStr)
        }
        
        for (i,data) in personalityData.enumerated() {
            
            var newQuestions: [Question] = []
            
            for string in data {
                newQuestions.append(Question(string: string, section: techJobs[i]))
            }
            allQuestions.append(newQuestions)
        }
        
        tableView.separatorStyle = .none
        nextButton.layer.cornerRadius = 20
        
        for i in 0..<5 {
            let quizObject = QuizGroup(sectionName: techJobs[i], questions: allQuestions[i])
            print(quizObject)
            objectsArray.append(quizObject)
        }
        
        DispatchQueue.main.async {
            self.activateResultButton()

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activateResultButton()
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
        print("love")
        
        //logic here - based on the results, it will segue to a different tech type
        // algo needed
        
        let t = "1"
        let truesInQa = qa.filter{$0 == t}.count
        let truesInIt = it.filter{$0 == t}.count
        let truesInWd = wd.filter{$0 == t}.count
        let truesInMd = md.filter{$0 == t}.count
        let truesInDa = da.filter{$0 == t}.count
    
        
        /*
        
         performSegue(withIdentifier: "resultToWD", sender: self)
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
            case 0, 1, 2, 3:
                qa[row] = "1"
            default:
                break
            }
        case 1:
            print("IT Engineer")
            switch row {
            case 0, 1, 2, 3:
                it[row] = "1"
            default:
                break
            }
        case 2:
            print("Web Developer")
            switch row {
            case 0, 1, 2, 3:
                wd[row] = "1"
            default:
                break
            }
        case 3:
            print("Mobile Developer")
            switch row {
            case 0, 1, 2, 3:
                md[row] = "1"
            default:
                break
            }
        case 4:
            print("Data Analyst")
            switch row {
            case 0, 1, 2, 3:
                da[row] = "1"
            default:
                break
            }
        default:
            break
        }
    
        self.activateResultButton()

        print("\n\(qa)\n\(it)\n\(wd)\n\(md)\n\(da)")
        
    }
    
    
    func noForEachTechType(section: Int, row: Int){
        
        switch section {
        case 0:
            print("Quality Assurance Analyst")
            switch row {
            case 0, 1, 2, 3:
                qa[row] = "0"
            default:
                break
            }
        case 1:
            print("IT Engineer")
            switch row {
            case 0, 1, 2, 3:
                it[row] = "0"
            default:
                break
            }
        case 2:
            print("Web Developer")
            switch row {
            case 0, 1, 2, 3:
                wd[row] = "0"
            default:
                break
            }
        case 3:
            print("Mobile Developer")
            switch row {
            case 0, 1, 2, 3:
                md[row] = "0"
            default:
                break
            }
        case 4:
            print("Data Analyst")
            switch row {
            case 0, 1, 2, 3:
                da[row] = "0"
            default:
                break
            }
        default:
            break
        }

        DispatchQueue.main.async {
            self.activateResultButton()

        }
        print("\n\(qa)\n\(it)\n\(wd)\n\(md)\n\(da)")
    }
    

    func activateResultButton(){
        let qaCount = qa.filter{$0 == ""}.count
        let itCount = it.filter{$0 == ""}.count
        let wdCount = wd.filter{$0 == ""}.count
        let mdCount = md.filter{$0 == ""}.count
        let daCount = da.filter{$0 == ""}.count
        
        let allQuestionsToBeResponded = qa.count + it.count + wd.count + md.count + da.count //20
        let allEmptyStrs = qaCount + itCount + wdCount + mdCount + daCount
        respondedQuestions = 20 - allEmptyStrs
    
        if allEmptyStrs > 0 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
  
        progressLabel.text = "\(respondedQuestions)/\(allQuestionsToBeResponded)"

    }
}
