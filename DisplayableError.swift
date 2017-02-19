//
//  DisplayableError.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/19/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

class DisplayableError: ErrorDisplaying {
    let backingError: Error?
    var userInfo: [String: Any]?
    
    init(backingError: Error? = nil, errorSourceFile: StaticString = #file, errorSourceLine: Int = #line, errorSourceFunction: StaticString = #function) {
        self.backingError = backingError
    }
    
    var errorName: String { return "\(Mirror(reflecting: self).subjectType)" }
    var displayTitle: String { return "Error" }
    var displayMessage: String { return "Sorry, an error occurred. Please try again later." }
    
    //MARK: Debugging
    var debugDescription: String {
        let className = self.errorName
        
        var errMsg: String?
        
        switch (self.backingError, self.userInfo) {
        case (.some(let error), .some(let userInfo)):
            errMsg = "\(error)[userInfo: \(userInfo)]"
        case (.some(let error), _):
            errMsg = "\(error)"
        case (_, .some(let userInfo)):
            errMsg = "[userInfo: \(userInfo)]"
        default:
            errMsg = nil
        }
        
        if let err = errMsg {
            return "{\"\(displayTitle)\"(\(className)): \(self.displayMessage)(err: \(err))}"
        } else {
            return "{\"\(displayTitle)\"(\(className)): \(self.displayMessage)}"
        }
    }
}
