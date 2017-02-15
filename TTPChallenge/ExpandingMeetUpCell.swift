//
//  ExpandingCell.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class ExpandingMeetUpCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var memberCount: UILabel!
    
    @IBOutlet weak var summary: UITextView!
    
    @IBOutlet weak var titleHeight: NSLayoutConstraint!
    
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var memberLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var summaryHeight: NSLayoutConstraint!
    
    @IBOutlet weak var favBtnHeight: NSLayoutConstraint!
    
    var isExpanded = false
//        {
//        didSet
//        {
//            if !isExpanded {
//                self.summaryHeight.constant = 0.0
//                
//            }
////            else {
////                self.imgHeightConstraint.constant = 128.0
////            }
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func favBtnTouched(_ sender: UIButton) {
        
    }

}
