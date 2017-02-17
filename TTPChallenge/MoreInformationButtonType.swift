//
//  MoreInformationButtonType.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

enum MoreInformationButtonType {
    case RetakeTheQuiz, TechTalk, AboutTTP, LearnMore
}

struct MoreInformationButton {
    var type: MoreInformationButtonType!
    var name: String?
}
