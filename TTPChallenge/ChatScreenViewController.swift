//
//  ChatScreenViewController.swift
//  TTPChallenge
//
//  Created by Stephanie on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Firebase
import JSQMessagesViewController

final class ChatViewController: JSQMessagesViewController {
    var channelRef: FIRDatabaseReference?
    var channel: Channel? {
        didSet {
            title = channel?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = FIRAuth.auth()?.currentUser?.uid

    }
}
