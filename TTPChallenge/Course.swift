//
//  Courses.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/20/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

class Course {
    
    let name: String
    let summary: String
    var image: UIImage?
    var delegate: UpdateTableView?
    var imageUrl: String?
    var favorited = false
    var url: String
    
    init(dictionary: [String:Any]) {
        
        name = dictionary["name"] as! String
        url = dictionary["url"] as! String
        imageUrl = dictionary["imageURL"] as? String
        summary = dictionary["summary"] as! String
        
        imageUrl?.downloadedFromURLString(completion: { (picture) in
            
            let resizedImage = picture.resizeImage(targetSize: CGSize(width: 500.0, height: 250.0))
            self.image = resizedImage
            self.delegate?.updateTableView()
        })
    }
}
