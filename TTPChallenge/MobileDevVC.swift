//
//  MobileDevVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit
import SafariServices

class MobileDevVC: UIViewController {
    
    @IBOutlet var informationButtons:[UIButton]!
    @IBOutlet weak var retakeQuizButton: UIButton!
    
    var buttons = [UIButton]()
    
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
            if let url = URL(string: "https://ttp.nyc/accelerated-programs") {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            }
        case 1:
            if let url = URL(string: "https://ttp.nyc/cuny-programs") {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            }
        case 2:
            if let url = URL(string: "https://ttp.nyc/join") {
                let safariVC = SFSafariViewController(url: url)
                present(safariVC, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    @IBAction func retakeQuizBtnTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
