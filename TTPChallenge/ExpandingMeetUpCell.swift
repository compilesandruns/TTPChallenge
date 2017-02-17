//
//  ExpandingCell.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class ExpandingMeetUpCell: UITableViewCell {
    
    var meetup: MeetUp!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    var starButton: DOFavoriteButton?
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var summary: UITextView!
    
    var isExpanded:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addFavButton()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    func addFavButton(){
        
        let x = mainImage.frame.origin.x
        let y = mainImage.frame.origin.y
        
        starButton = DOFavoriteButton(frame: CGRect(x: x, y: y, width: 50, height: 50), image: UIImage(named: "star"))
        
        starButton!.addTarget(self, action: #selector(favBtnTouched(sender:)), for: .touchUpInside)

        self.contentView.addSubview(starButton!)
    }
    
    func favBtnTouched(sender: UIButton) {
        
        let favSender = sender as! DOFavoriteButton
        
        if sender.isSelected {
            
            removeFavorite(meetup: meetup)
            favSender.deselect()
        } else {
            saveFavorite(meetup: meetup)
            favSender.select()
        }
    }
    
    func saveFavorite(meetup: MeetUp) {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : String]]
        
        var favMeetup = ["name" : meetup.name,
                         "summary" : meetup.summary]
        
        if let url = meetup.url {
            favMeetup["url"] = url
        }
        if let favs = favs{

            var updatedFavs = favs
            updatedFavs.append(favMeetup)
            defaults.set(updatedFavs, forKey: "favMeetups")
            
        } else {
            
            defaults.set([favMeetup], forKey: "favMeetups")
            
        }
    }
    
    func removeFavorite(meetup: MeetUp){
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : String]]
        
        guard let unwrappedFavs = favs else{return}
        
        for (index, each) in unwrappedFavs.enumerated(){
            
            guard let name = each["name"] else{return}
            
            if meetup.name == name {
                
                var adjustedFav = unwrappedFavs
                adjustedFav.remove(at: index)
                defaults.set(adjustedFav, forKey: "favMeetups")
            }
        }
    }
}

