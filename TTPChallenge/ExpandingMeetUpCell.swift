//
//  ExpandingCell.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class ExpandingMeetUpCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var summary: UITextView!

    var isExpanded:Bool = false
    
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
