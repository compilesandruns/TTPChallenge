//
//  AllTechTypesVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit
import SafariServices

class AllTechTypesVC: UIViewController {

    @IBOutlet var allTechJobsButtons: [UIButton]!
    
    @IBOutlet weak var retakeQuizButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func techTypeBtnTapped(_ sender: UIButton) {
        
        let index = sender.tag
        
        switch index {
        case 0:
            print("qa")
        case 1:
            print("it")
        case 2:
            print("wd")
        case 3:
            print("md")
        case 4:
            print("da")
        default:
            break
        }

    }
    
    @IBAction func retakeQuizBtnTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "backHomeFromAllType", sender: self)
    }

}
