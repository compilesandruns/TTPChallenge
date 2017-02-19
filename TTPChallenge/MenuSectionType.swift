//
//  MenuSectionType.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/17/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

enum MenuSectionType {
    case Discover, Connect, Learn
}

struct MenuSection {
    var type: MenuSectionType!
    var name: String?
    var buttons: [MoreInformationButton] = []
}
