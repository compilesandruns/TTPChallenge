//
//  PersonalityTestCell.swift
//  TTPChallenge
//
//  Created by Luna An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

@IBDesignable class PersonalityTestCell: UITableViewCell {
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBInspectable @IBOutlet weak var personalityView: UIView!
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
        tapActionForYes?(self)
        yesButton.isSelected = true
        noButton.isSelected = false
    }
    
    @IBAction func noTapped(_ sender: Any) {
        question.changeToNo()
        tapActionForNo?(self)
        noButton.isSelected = true
        yesButton.isSelected = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
}



