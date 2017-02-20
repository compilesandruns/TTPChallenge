//
//  ExpandingCell.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class ExpandingCoursesCell: UITableViewCell {
    
    var course: Course!
    
    var delegateAlert: CustomCellPresentAlert?
    
    @IBOutlet weak var mainImage: UIImageView!
    
    var starButton: DOFavoriteButton?
    
    var joinbutton: DOFavoriteButton?
    
//    @IBOutlet weak var summaryTextView: UITextView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var summary: UITextView!
    
    var delegate: RemoveFavorite?
    
    var isExpanded: Bool = false
    
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
        
        starButton = DOFavoriteButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50), image: UIImage(named: "star"))
        self.contentView.addSubview(starButton!)
        
        starButton?.translatesAutoresizingMaskIntoConstraints = false
        starButton?.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.25).isActive = true
        starButton?.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.135).isActive = true
        
        starButton?.leadingAnchor.constraint(equalTo: mainImage.leadingAnchor).isActive = true
        starButton?.topAnchor.constraint(equalTo: mainImage.topAnchor).isActive = true
        starButton?.lineColor = UIColor.white
        starButton!.addTarget(self, action: #selector(favBtnTouched(sender:)), for: .touchUpInside)
        
    }
    
    func addJoinButton() {
        
        joinbutton = DOFavoriteButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50), image: UIImage(named: "join"))
        
        self.contentView.addSubview(joinbutton!)
        joinbutton?.translatesAutoresizingMaskIntoConstraints = false
        joinbutton?.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.25).isActive = true
        joinbutton?.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.135).isActive = true
        
        joinbutton?.trailingAnchor.constraint(equalTo: mainImage.trailingAnchor).isActive = true
        joinbutton?.topAnchor.constraint(equalTo: mainImage.topAnchor).isActive = true
        joinbutton?.imageColorOn = UIColor.white
        joinbutton?.imageColorOff = UIColor.white
        joinbutton?.circleColor = UIColor.white
        joinbutton?.lineColor = UIColor.white
        joinbutton!.addTarget(self, action: #selector(joinButtonTouched(sender:)), for: .touchUpInside)
        
    }
    
    func favBtnTouched(sender: UIButton) {
        
        let favSender = sender as! DOFavoriteButton
        
        if sender.isSelected {
            course.favorited = false
            removeFavorite(course: course)
            favSender.deselect()
        } else {
            course.favorited = true
            saveFavorite(course: course)
            favSender.select()
        }
    }
    
    func saveFavorite(course: Course) {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favCourses") as? [[String : Any]]
        
        var favCourses: [String : Any] = ["name" : course.name,
                                         "summary" : course.summary,
                                         "url" : course.url,
                                         "favorited" : course.favorited]
        
        if let imageURL = course.imageUrl {
            favCourses["imageURL"] = imageURL
        }
        
        if let favs = favs {
            
            var updatedFavs = favs
            updatedFavs.append(favCourses)
            defaults.set(updatedFavs, forKey: "favCourses")
            
        } else {
            
            defaults.set([favCourses], forKey: "favCourses")
        }
    }
    
    func removeFavorite(course: Course) {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favCourses") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else { return }
        
        for (index, each) in unwrappedFavs.enumerated() {
            
            let name = each["name"] as! String
            
            if course.name == name {
                
                var adjustedFav = unwrappedFavs
                adjustedFav.remove(at: index)
                defaults.set(adjustedFav, forKey: "favCourses")
                delegate?.removeFavorite(name: name)
            }
        }
    }
    
    func joinButtonTouched(sender: UIButton) {
        
        let joinSender = sender as! DOFavoriteButton
        if joinSender.isSelected {
            joinSender.deselect()
        } else {
            joinSender.select()
            visitMeetupWebsite(course: course)
        }
    }
    
    func visitMeetupWebsite(course: Course) {
        
        self.delegateAlert?.showAlert(urlString : course.url)
    }
    
    func configureCell() {
        
        self.title.text = course.name
        
        self.mainImage.image = self.course.image
        
        self.summary.textAlignment = self.isExpanded ? .left : .center
        
        self.summary.text = self.isExpanded ? course.summary : "Read More"
        
        self.summary.backgroundColor = self.isExpanded ? UIColor.white : UIColor(red: 54/255, green: 34/255, blue: 149/255, alpha: 1.0)
        
        self.summary.textColor = self.isExpanded ? UIColor.black : UIColor.white
        
        self.starButton?.isSelected = checkIfFavorited()
        
        self.selectionStyle = .none
    }
    
    func checkIfFavorited() -> Bool {
        
        let defaults = UserDefaults.standard
        
        let favs = defaults.object(forKey: "favCourses") as? [[String : Any]]
        
        guard let unwrappedFavs = favs else { return false }
        
        for each in unwrappedFavs {
            
            let name = each["name"] as! String
            
            if course.name == name {
                
                return true
            }
        }
        return false
    }
}

