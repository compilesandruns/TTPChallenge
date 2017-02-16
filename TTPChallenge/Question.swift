//
//  Question.swift
//  TTPChallenge
//
//  Created by Luna An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

final class Question {
    
    let string: String
    var selectedYes: Bool = false
    var selectedNo: Bool = false
    
    init(string: String) {
        self.string = string
    }
    
    func changeToYes() {
        selectedNo = false
        selectedYes = true
    }
    
    func changeToNo() {
        selectedNo = true
        selectedYes = false
    }
    
}
