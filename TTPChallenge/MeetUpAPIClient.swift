//
//  MeetUpAPIClient.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

class MeetUpAPIClient {
    
    class func getMeetupSuggestions(query: String, with completion: @escaping ([[String : Any]]) -> ()) {

        let urlString = "https://api.meetup.com/find/groups?&sign=true&photo-host=public&upcoming_events=true&fallback_suggestions=true&text=\(query)&category=34&order=most_active&page=3&key=\(Secrets.key)"
        
        let url = URL(string: urlString)
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            do {
                guard let unwrappedata = data else { print("i have no data"); return }
                
                let results = try JSONSerialization.jsonObject(with: unwrappedata, options: []) as? [[String : Any]]
                
                if let results = results {

                    completion(results)
                }
            } catch {
                
                print(error)
            }
        }
        task.resume()
    }
}
