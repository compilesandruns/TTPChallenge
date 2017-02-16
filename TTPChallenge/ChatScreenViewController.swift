//
//  ChatScreenViewController.swift
//  TTPChallenge
//
//  Created by Stephanie on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

enum Section: Int {
    case createNewChannelSection = 0
    case currentChannelsSection
}

class ChatScreenViewController: BaseViewController {

    var senderDisplayName: String?
    var newChannelTextField: UITextField?
    private var channels: [Channel] = []
    
}
