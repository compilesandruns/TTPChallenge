//
//  QuizMainVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class QuizMainVC: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var partOneCircle: UILabel!
    @IBOutlet weak var partTwoCircle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styling elements
        startButton.layer.cornerRadius = 20
        partOneCircle.layer.cornerRadius = partOneCircle.frame.width/2
        partOneCircle.layer.masksToBounds = true
        partTwoCircle.layer.cornerRadius = partTwoCircle.frame.width/2
        partTwoCircle.layer.masksToBounds = true
        
        
        // Trasnparent navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        print("\nThis is about to get called.")
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
}
