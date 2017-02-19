//
//  ValidationError.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/19/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation
import SwiftyJSON

class ValidationError: DisplayableError {
    private(set) var errors = [String]()
    
    init(errors: [String], errorSourceFile: StaticString = #file, errorSourceLine: Int = #line, errorSourceFunction: StaticString = #function) {
        self.errors = errors
        
        super.init(backingError: nil, errorSourceFile: errorSourceFile, errorSourceLine: errorSourceLine, errorSourceFunction: errorSourceFunction)
    }
    
    init?(json: JSON?, backingError: Error? = nil, errorSourceFile: StaticString = #file, errorSourceLine: Int = #line, errorSourceFunction: StaticString = #function) {
        guard let jsonObj = json, let errorDict = try? jsonObj.dictionaryValue, jsonObj != JSON.null && !jsonObj.isEmpty else {
            return nil
        }
        
        for (key, values) in errorDict {
            guard let values = values.array else {
                continue
            }
            for value in values {
                guard let value = value.string else {
                    continue
                }
                let errorName = key.components(separatedBy:("_")).joined(separator: " ")
                
                errors.append("\(errorName) \(value).")
            }
        }
        
        guard errors.count > 0 else {
            return nil
        }
        
        super.init(backingError: backingError, errorSourceFile: errorSourceFile, errorSourceLine: errorSourceLine, errorSourceFunction: errorSourceFunction)
    }
    
    override var displayMessage: String {
        return errors.map({ (err) -> String in err.capitalized }).joined(separator: "\n")
    }
    
    override var displayTitle: String { return "Please fix the following:" }
}
