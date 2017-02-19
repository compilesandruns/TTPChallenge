//
//  MenuTableViewCell.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buttonLabel: UILabel!
    
    override func awakeFromNib() {
        self.backgroundView = UIView()
        self.backgroundView!.backgroundColor = UIColor(red: 0, green: 47/255.0, blue: 77/255.0, alpha: 1.0)
        
        let selectedView = UIView()
        
        selectedView.backgroundColor = UIColor(red: 14/255.0, green: 77/255.0, blue: 118/255.0, alpha: 1.0)
        
        selectedBackgroundView = selectedView
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        buttonLabel.text = ""
        accessibilityLabel = ""
    }
}
