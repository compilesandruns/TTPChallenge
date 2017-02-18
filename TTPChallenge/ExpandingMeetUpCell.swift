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
    
    var joinbutton: DOFavoriteButton?
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var summary: UITextView!
    
    var delegate: RemoveFavorite?
    
    var isExpanded:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addFavButton()
        addJoinButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    func addFavButton(){
        
        let x = mainImage.frame.origin.x
        let y = mainImage.frame.origin.y
        
        starButton = DOFavoriteButton(frame: CGRect(x: x, y: y, width: 50, height: 50), image: UIImage(named: "star"))
        starButton?.lineColor = UIColor.white
        starButton!.addTarget(self, action: #selector(favBtnTouched(sender:)), for: .touchUpInside)

        self.contentView.addSubview(starButton!)
    }
    
    func favBtnTouched(sender: UIButton) {
        
        let favSender = sender as! DOFavoriteButton
        
        if sender.isSelected {
            meetup.favorited = false
            removeFavorite(meetup: meetup)
            favSender.deselect()
        } else {
            meetup.favorited = true
            saveFavorite(meetup: meetup)
            favSender.select()
        }
    }
    
    func saveFavorite(meetup: MeetUp) {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
        
        var favMeetup: [String : Any] = ["name" : meetup.name,
                         "summary" : meetup.summary,
                         "url" : meetup.url,
                         "favorited": meetup.favorited]
        
        
        if let url = meetup.imageUrl {
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
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else{return}
        
        for (index, each) in unwrappedFavs.enumerated(){
            
            let name = each["name"] as! String
            
            if meetup.name == name {
                
                var adjustedFav = unwrappedFavs
                adjustedFav.remove(at: index)
                defaults.set(adjustedFav, forKey: "favMeetups")
                delegate?.removeFavorite(name: name)
            }
        }
    }
    
    func addJoinButton(){
        
        let x = mainImage.frame.origin.x + mainImage.frame.width - 25
        let y = mainImage.frame.origin.y
        joinbutton = DOFavoriteButton(frame: CGRect(x: x, y: y, width: 50, height: 50), image: UIImage(named: "join"))
        joinbutton?.imageColorOn = UIColor.white
        joinbutton?.imageColorOff = UIColor.white
        joinbutton?.circleColor = UIColor.white
        joinbutton?.lineColor = UIColor.white
        joinbutton!.addTarget(self, action: #selector(joinButtonTouched(sender:)), for: .touchUpInside)
        
        self.contentView.addSubview(joinbutton!)
    }
    
    func joinButtonTouched(sender: UIButton){
        
        let joinSender = sender as! DOFavoriteButton
        if joinSender.isSelected {
            joinSender.deselect()
        } else {
            joinSender.select()
            visitMeetupWebsite(meetup: meetup)
        }
    }
    
    func visitMeetupWebsite(meetup: MeetUp){
        //todo uncomment when rolling out
//        UIApplication.shared.open(URL(string: meetup.url)!, options: [:]) { (success) in
//            
//            print("peace ouuuuuttt")
//        }
//        
    }
}

protocol RemoveFavorite {
    
    func removeFavorite(name: String)
}

