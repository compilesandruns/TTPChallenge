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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...4 {
            qa.append(Answer.none)
            it.append(Answer.none)
            wd.append(Answer.none)
            md.append(Answer.none)
            da.append(Answer.none)
        }
        for (i,data) in Quizzes.personalityData.enumerated() {
            var newQuestions: [Question] = []
            
            for string in data {
                newQuestions.append(Question(string: string, section: Quizzes.techJobs[i]))
            }
            allQuestions.append(newQuestions)
        }
        tableView.separatorStyle = .none
        nextButton.layer.cornerRadius = 20
        
        for i in 0..<5 {
            let quizObject = QuizGroup(sectionName: Quizzes.techJobs[i], questions: allQuestions[i])
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
        return Quizzes.techJobs.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.personalityCell, for: indexPath) as! PersonalityTestCell
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
        
        let yesesInQa = qa.filter{$0 == Answer.yes}.count
        let yesesInIt = it.filter{$0 == Answer.yes}.count
        let yesesInWd = wd.filter{$0 == Answer.yes}.count
        let yesesInMd = md.filter{$0 == Answer.yes}.count
        let yesesInDa = da.filter{$0 == Answer.yes}.count
        
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
                techJobsForResult.append(Quizzes.techJobs[n])
            }
        }
        performSegue(withIdentifier: Identifier.Segue.toResult, sender: self)
    }
    
    func yesForEachTechType(section: Int, row: Int){
        
        switch section {
        case 0:
            switch row {
            case 0, 1, 2, 3:
                qa[row] = Answer.yes
            default:
                break
            }
        case 1:
            switch row {
            case 0, 1, 2, 3:
                it[row] = Answer.yes
            default:
                break
            }
        case 2:
            switch row {
            case 0, 1, 2, 3:
                wd[row] = Answer.yes
            default:
                break
            }
        case 3:
            switch row {
            case 0, 1, 2, 3:
                md[row] = Answer.yes
            default:
                break
            }
        case 4:
            switch row {
            case 0, 1, 2, 3:
                da[row] = Answer.yes
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
                qa[row] = Answer.no
            default:
                break
            }
        case 1:
            switch row {
            case 0, 1, 2, 3:
                it[row] = Answer.no
            default:
                break
            }
        case 2:
            switch row {
            case 0, 1, 2, 3:
                wd[row] = Answer.no
            default:
                break
            }
        case 3:
            switch row {
            case 0, 1, 2, 3:
                md[row] = Answer.no
            default:
                break
            }
        case 4:
            switch row {
            case 0, 1, 2, 3:
                da[row] = Answer.no
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
        let qaCount = qa.filter{$0 == Answer.none}.count
        let itCount = it.filter{$0 == Answer.none}.count
        let wdCount = wd.filter{$0 == Answer.none}.count
        let mdCount = md.filter{$0 == Answer.none}.count
        let daCount = da.filter{$0 == Answer.none}.count
        
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
        if segue.identifier == Identifier.Segue.toResult {
            let destVC = segue.destination as! QuizResultVC
            DispatchQueue.main.async {
                destVC.indexArrayPassed = self.jobIndexArray
                destVC.techTypesFromResults = self.techJobsForResult
            }
        }
    }
}
