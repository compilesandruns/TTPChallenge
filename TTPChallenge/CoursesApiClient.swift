//
//  CoursesApiClient.swift
//  TTPChallenge
//
//  Created by susan lovaglio on 2/20/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

class CoursesApiClient {
    
    class func getCourses(query: String, with completion: @escaping ([String : Any]) -> ()) {
        //not using query - results of quiz aren't saved
        let path = Bundle.main.path(forResource: "Courses", ofType: "json")
        
//        let data = 
//        let session = URLSession.shared
//        
//        let task = session.dataTask(with: url!) { (data, response, error) in
//            
//            do {
//                guard let unwrappedata = data else { print("i have no data"); return }
//                
//                let results = try JSONSerialization.jsonObject(with: unwrappedata, options: []) as? [String : Any]
//                
//                if let results = results {
//                    
//                    completion(results)
//                }
//            } catch {
//                
//                print(error)
//            }
//        }
//        task.resume()
    }
}
