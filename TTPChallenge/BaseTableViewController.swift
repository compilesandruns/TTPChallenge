//
//  BaseTableViewController.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController, AlertView {
    var currentMainViewController: UIViewController { return self }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
