//
//  PersonalityTestCell.swift
//  TTPChallenge
//
//  Created by Mirim An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class PersonalityTestCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
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



