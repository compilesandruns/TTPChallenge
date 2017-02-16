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
    
    var starButton: DOFavoriteButton?
    
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
        
//        if starButton == nil{
//            addFavButton(cell: self)
//        }
    }
    
//    func addFavButton(cell: ExpandingMeetUpCell){
//        
//        cell.starButton = DOFavoriteButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44), image: UIImage(named: "star"))
//        
//        cell.starButton?.addTarget(self, action: #selector(favBtnTouched(sender:)), for: .touchUpInside)
//        cell.mainImage.addSubview(cell.starButton!)
//    }
    
//    func favBtnTouched(sender: DOFavoriteButton) {
//        
//        if sender.isSelected {
//            sender.deselect()
//        } else {
//            sender.select()
//        }
//    }
    
}
