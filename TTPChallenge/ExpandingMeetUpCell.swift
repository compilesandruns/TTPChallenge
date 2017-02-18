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
    
    var delegateAlert:CustomCellPresentAlert?
    
    @IBOutlet weak var mainImage: UIImageView!
    
    var starButton: DOFavoriteButton?
    
    var joinbutton: DOFavoriteButton?
    
    @IBOutlet weak var summaryTextView: UITextView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var summary: UITextView!
    
    var delegate: RemoveFavorite?
    
    var isExpanded:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addFavButton()
        addJoinButton()
        summary.layer.cornerRadius = 5.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    func addFavButton() {
        
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
                                         "favorited" : meetup.favorited]
        
        if let imageURL = meetup.imageUrl {
            favMeetup["imageURL"] = imageURL
        }
        
        if let favs = favs {
            
            var updatedFavs = favs
            updatedFavs.append(favMeetup)
            defaults.set(updatedFavs, forKey: "favMeetups")
            
        } else {
            
            defaults.set([favMeetup], forKey: "favMeetups")
        }
    }
    
    func removeFavorite(meetup: MeetUp) {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else { return }
        
        for (index, each) in unwrappedFavs.enumerated() {
            
            let name = each["name"] as! String
            
            if meetup.name == name {
                
                var adjustedFav = unwrappedFavs
                adjustedFav.remove(at: index)
                defaults.set(adjustedFav, forKey: "favMeetups")
                delegate?.removeFavorite(name: name)
            }
        }
    }
    
    func addJoinButton() {
        
        let x = mainImage.frame.origin.x + mainImage.frame.width - 10
        let y = mainImage.frame.origin.y
        joinbutton = DOFavoriteButton(frame: CGRect(x: x, y: y, width: 50, height: 50), image: UIImage(named: "join"))
        joinbutton?.imageColorOn = UIColor.white
        joinbutton?.imageColorOff = UIColor.white
        joinbutton?.circleColor = UIColor.white
        joinbutton?.lineColor = UIColor.white
        joinbutton!.addTarget(self, action: #selector(joinButtonTouched(sender:)), for: .touchUpInside)
        
        self.contentView.addSubview(joinbutton!)
    }
    
    func joinButtonTouched(sender: UIButton) {
        
        let joinSender = sender as! DOFavoriteButton
        if joinSender.isSelected {
            joinSender.deselect()
        } else {
            joinSender.select()
            visitMeetupWebsite(meetup: meetup)
        }
    }
    
    func visitMeetupWebsite(meetup: MeetUp) {
        
        self.delegateAlert?.showAlert(meetup: meetup)
    }
    
    func configureCell() {
        
        self.title.text = meetup.name
        
        self.mainImage.image = self.meetup.image
        
        self.summary.textAlignment = self.isExpanded ? .left : .center
        
        self.summary.text = self.isExpanded ? meetup.summary : "Read More"
        
        self.summary.backgroundColor = self.isExpanded ? UIColor.white : UIColor(red: 54/255, green: 34/255, blue: 149/255, alpha: 1.0)
        
        self.summary.textColor = self.isExpanded ? UIColor.black : UIColor.white
        
        self.starButton?.isSelected = checkIfFavorited()
        
        self.selectionStyle = .none
    }
    
    func checkIfFavorited() -> Bool {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else { return false }
        
        for each in unwrappedFavs {
            
            let name = each["name"] as! String
            
            if meetup.name == name {
                
                return true
            }
        }
        return false
    }
}

protocol RemoveFavorite {
    
    func removeFavorite(name: String)
}

protocol CustomCellPresentAlert {
    func showAlert(meetup: MeetUp)
}

//func to print contents of nsuserdefaults meetups saves in a legible config
func printFavNames(message: String) {
    let defaults = UserDefaults.standard
    
    let favs = defaults.object(forKey: "favMeetups") as? [[String : Any]]
    
    guard let unwrappedFavs = favs else { return }
    print("*******")
    print(message)
    for each in unwrappedFavs {
        
        print("/n\(each["name"]!)")
    }
    print("*******")
}
