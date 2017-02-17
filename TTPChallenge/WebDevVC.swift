//
//  WebDevVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit
import SafariServices

class WebDevVC: UIViewController {
    
    @IBOutlet var informationButtons:[UIButton]!
    
    @IBOutlet weak var retakeQuizButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in informationButtons {
            button.layer.cornerRadius = 12
        }
        retakeQuizButton.layer.cornerRadius = 20
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
            if let url = URL(string: URLS.cunyProgram) {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            }
        case 2:
            if let url = URL(string: URLS.signUpForTTP) {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    @IBAction func retakeQuizBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
        
}
