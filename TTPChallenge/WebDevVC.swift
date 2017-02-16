//
//  WebDevVC.swift
//  TTPChallenge
//
//  Created by Mirim An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class WebDevVC: UIViewController {
    
    @IBOutlet var informationButtons:[UIButton]!
    
    @IBOutlet weak var retakeQuizButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        for button in informationButtons {
            button.layer.cornerRadius = 12
        }
        retakeQuizButton.layer.cornerRadius = 20

        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func informationBtnTapped(_ sender: UIButton) {
        
        let index = sender.tag
        switch index {
        case 0:
            print("open safari for 1")
        case 1:
            print("open safari for 2")
        case 2:
            print("open safari for 3")
        default:
            break
        }

    }
    
    
    
    
    @IBAction func retakeQuizBtnTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
