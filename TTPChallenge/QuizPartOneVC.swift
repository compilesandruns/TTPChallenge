//
//  QuizPartOneVC.swift
//  TTPChallenge
//
//  Created by Mirim An on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class QuizPartOneVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var tableView: UITableView!
    let customView = UIView(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 42))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        addButtonToFooter()
        tableView.tableFooterView = customView
     
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // Tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personalityCell", for: indexPath) as! PersonalityTestCell
        cell.questionLabel.text = personalityData[indexPath.row]
        
        // personalityView styling
        cell.personalityView.layer.cornerRadius = 4
        cell.personalityView.layer.masksToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func addButtonToFooter(){
        // Next button
        customView.backgroundColor = .clear
        let button = UIButton(frame: CGRect(x: customView.center.x, y: 0, width: 135, height: 40))
        button.backgroundColor = UIColor(red: 46/255.0, green: 49/255.0, blue: 146/255.0, alpha: 1)

        button.layer.cornerRadius = 20
        button.setTitle("Next  >", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        customView.addSubview(button)
    }
    
    func buttonAction(sender: UIButton){
        print("next button tapped")
    }
    

}

class PersonalityTestCell: UITableViewCell {
    
    @IBOutlet weak var personalityView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var noLabel: UILabel!
    
}
