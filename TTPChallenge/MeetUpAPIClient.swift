//
//  MeetUpAPIClient.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

class MeetUpAPIClient {
    
    
    class func getMeetupSuggestions(query: String, with completion: @escaping () -> ()) {
        
        let urlString = "https://api.meetup.com/2/events?key=\(Secrets.key)&group_urlname=ny-tech&sign=true"
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            guard let unwrappedData = data else{completion(); return}
            
            do{
                let results = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                
                print(results)
                
            } catch {
                
                print(error)
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
