//
//  DataStore.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/18/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

class DataStore {
    
    static let shared = DataStore.init()
    
    var meetups: [MeetUp] = []
    
    var courses: [Course] = []
    
    func fillMeetupStore(with completion: @escaping (Bool)->()) {
        
        MeetUpAPIClient.getMeetupSuggestions(query: "women") { meetupResults in
            
            for each in meetupResults {
                
                let name = each["name"] as? String
                let count = each ["members"] as? Int
                let summary = each["description"] as? String
                let photo = each["key_photo"] as? [String : Any]
                let url = each["link"] as? String
                if let photo = photo,
                    let name = name,
                    let count = count,
                    let summary = summary,
                    let url = url {
                    
                    let photoURL = photo["photo_link"] as? String
                    if let photoURL = photoURL {
                        
                        let meetup = MeetUp(name: name, memberCount: count, summary: summary, imageUrl: photoURL, url: url)
                        self.meetups.append(meetup)
                        completion(true)
                    }
                }
            }
        }
    }
    
    
    func fillCoursesStore(query: String, with completion: @escaping (Bool) -> ()){
        
        let url = Bundle.main.url(forResource: "Courses", withExtension: "json")
        let data = try! Data(contentsOf: url!, options: [])
        
        do {
            let results = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            
            let queryResult = results[query] as! [[String:String]]
            
            for each in queryResult{
                
                let course = Course(dictionary: each)
                self.courses.append(course)
            }
        } catch {
            print(error)
            completion(false)
        }
        completion(true)
    }
}
