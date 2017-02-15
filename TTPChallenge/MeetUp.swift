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
    
    init(name: String, memberCount: Int, summary: String) {
        
        self.name = name
        self.memberCount = memberCount
        self.summary = summary.removeHTML()
    }
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

        removed = removed.replacingOccurrences(of: "&nbsp;", with: " ")
        removed = removed.replacingOccurrences(of: "</span>", with: "")
        removed = removed.replacingOccurrences(of: "<span>", with: "")
        
        removed = removed.replacingOccurrences(of: "<br>", with: "")
        removed = removed.replacingOccurrences(of: "<ul>", with: "")
        removed = removed.replacingOccurrences(of: "</ul>", with: "")

        return removed
    }
}
