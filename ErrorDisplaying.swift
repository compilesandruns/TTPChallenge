//
//  ErrorDisplaying.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/19/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

protocol ErrorDisplaying: class, Error, CustomStringConvertible, CustomDebugStringConvertible {
    var errorName: String { get }
    var displayTitle: String { get }
    var displayMessage: String { get }
}

//MARK: - Debugging
extension ErrorDisplaying {
    var description: String {
        return "\(displayTitle): \(displayMessage)"
    }
    
    var debugDescription: String {
        let className = ("\(Mirror(reflecting: self).subjectType)")
        
        return "{\"\(displayTitle)\"(\(className)): \(self.displayMessage)}"
    }
}
