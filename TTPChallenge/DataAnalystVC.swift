//
//  DataAnalystVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit
import SafariServices

class DataAnalystVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func informationBtnTapped(_ sender: UIButton) {
        let index = sender.tag
        switch index {
        case 0:
            if let url = URL(string: URLS.acceleratedProgram) {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            }
        case 1:
            if let url = URL(string: URLS.signUpForTTP) {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    @IBAction func exit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
