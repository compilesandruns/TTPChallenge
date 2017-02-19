//
//  MeetUp.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

class MeetUp {
    
    let name: String
    let memberCount: Int
    let summary: String
    var image: UIImage?
    var delegate: UpdateTableView?
    var imageUrl: String?
    var favorited = false
    var url: String
    
    init(name: String, memberCount: Int, summary: String, imageUrl: String, url: String) {
        
        self.name = name
        self.memberCount = memberCount
        self.summary = summary.removeHTML()
        self.imageUrl = imageUrl
        self.url = url
                
        imageUrl.downloadedFromURLString(completion: { (picture) in
            
            let resizedImage = picture.resizeImage(targetSize: CGSize(width: 500.0, height: 250.0))
            self.image = resizedImage
            self.delegate?.updateTableView()
        })
    }
}

protocol UpdateTableView {
    
    func updateTableView()
}

extension String {
    
    func removeHTML() -> String {
        
        var removed = self
        
        removed = removed.replacingOccurrences(of: "<p>", with: "")
        removed = removed.replacingOccurrences(of: "</p>", with: "")
        
        removed = removed.replacingOccurrences(of: "<b>", with: "")
        removed = removed.replacingOccurrences(of: "</b>", with: "")
        
        removed = removed.replacingOccurrences(of: "<a href=", with: "")
        removed = removed.replacingOccurrences(of: "</a>", with: "")
        removed = removed.replacingOccurrences(of: "<a>", with: "")

        removed = removed.replacingOccurrences(of: "&nbsp;", with: " ")
        removed = removed.replacingOccurrences(of: "</span>", with: "")
        removed = removed.replacingOccurrences(of: "<span>", with: "")
        
        removed = removed.replacingOccurrences(of: "<br>", with: "")
        removed = removed.replacingOccurrences(of: "<ul>", with: "")
        removed = removed.replacingOccurrences(of: "</ul>", with: "")
        
        removed = removed.replacingOccurrences(of: ">", with: " ")
        return removed
    }

    func downloadedFromURLString(completion: @escaping (UIImage) -> Void) {
        
        guard let url = URL(string: self) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let result = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async() { () -> Void in
                completion(result)
            }
            }.resume()
    }
}

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        
        let widthRatio  = targetSize.width  / self.size.width
        let heightRatio = targetSize.height / self.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

