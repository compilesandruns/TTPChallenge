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
    var responsesArray: [Int] = []
    var techJobsForResult: [String] = []
    var jobIndexArray: [Int] = []
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
            qa.append(Answers.none.rawValue)
            it.append(Answers.none.rawValue)
            wd.append(Answers.none.rawValue)
            md.append(Answers.none.rawValue)
            da.append(Answers.none.rawValue)
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
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        
        let yesesInQa = qa.filter{$0 == Answers.yes.rawValue}.count
        let yesesInIt = it.filter{$0 == Answers.yes.rawValue}.count
        let yesesInWd = wd.filter{$0 == Answers.yes.rawValue}.count
        let yesesInMd = md.filter{$0 == Answers.yes.rawValue}.count
        let yesesInDa = da.filter{$0 == Answers.yes.rawValue}.count
        
        responsesArray = [yesesInQa, yesesInIt, yesesInWd, yesesInMd, yesesInDa]
        
        let max = responsesArray.max()
        if let maxN = max {
            var counter = 0
            
            for (i,n) in responsesArray.enumerated() {
                if n == maxN {
                    counter += 1
                    jobIndexArray.append(i)
                }
            }
            
            for n in jobIndexArray {
                techJobsForResult.append(techJobs[n])
            }
        }
        performSegue(withIdentifier: "toResult", sender: self)
    }
    
    func yesForEachTechType(section: Int, row: Int){
        
        switch section {
        case 0:
            switch row {
            case 0, 1, 2, 3:
                qa[row] = Answers.yes.rawValue
            default:
                break
            }
        case 1:
            switch row {
            case 0, 1, 2, 3:
                it[row] = Answers.yes.rawValue
            default:
                break
            }
        case 2:
            switch row {
            case 0, 1, 2, 3:
                wd[row] = Answers.yes.rawValue
            default:
                break
            }
        case 3:
            switch row {
            case 0, 1, 2, 3:
                md[row] = Answers.yes.rawValue
            default:
                break
            }
        case 4:
            switch row {
            case 0, 1, 2, 3:
                da[row] = Answers.yes.rawValue
            default:
                break
            }
        default:
            break
        }
        self.activateResultButton()
    }
    
    func noForEachTechType(section: Int, row: Int){
        
        switch section {
        case 0:
            switch row {
            case 0, 1, 2, 3:
                qa[row] = Answers.no.rawValue
            default:
                break
            }
        case 1:
            switch row {
            case 0, 1, 2, 3:
                it[row] = Answers.no.rawValue
            default:
                break
            }
        case 2:
            switch row {
            case 0, 1, 2, 3:
                wd[row] = Answers.no.rawValue
            default:
                break
            }
        case 3:
            switch row {
            case 0, 1, 2, 3:
                md[row] = Answers.no.rawValue
            default:
                break
            }
        case 4:
            switch row {
            case 0, 1, 2, 3:
                da[row] = Answers.no.rawValue
            default:
                break
            }
        default:
            break
        }

        DispatchQueue.main.async {
            self.activateResultButton()

        }
    }

    func activateResultButton(){
        let qaCount = qa.filter{$0 == Answers.none.rawValue}.count
        let itCount = it.filter{$0 == Answers.none.rawValue}.count
        let wdCount = wd.filter{$0 == Answers.none.rawValue}.count
        let mdCount = md.filter{$0 == Answers.none.rawValue}.count
        let daCount = da.filter{$0 == Answers.none.rawValue}.count
        
        let allQuestionsToBeResponded = qa.count + it.count + wd.count + md.count + da.count
        let allEmptyStrs = qaCount + itCount + wdCount + mdCount + daCount
        respondedQuestions = 20 - allEmptyStrs
    
        if allEmptyStrs > 0 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        progressLabel.text = "\(respondedQuestions)/\(allQuestionsToBeResponded)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let id = "toResult"
        if segue.identifier == id {
            let destVC = segue.destination as! QuizResultVC
            DispatchQueue.main.async {
                destVC.indexArrayPassed = self.jobIndexArray
                destVC.techTypesFromResults = self.techJobsForResult
            }
        }
    }
}
