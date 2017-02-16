//
//  Quiz.swift
//  TTPChallenge
//
//  Created by Mirim An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

struct QuizGroup {
    
    var sectionName : String
    var questions : [Question]
    var isYes = false
    
}

struct Quiz {
    
    var question : String
    var isYes = false
    
}
