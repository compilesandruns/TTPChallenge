//
//  QuizMainVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class QuizMainVC: BaseViewController {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var partOneCircle: UILabel!
    @IBOutlet weak var partTwoCircle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        partOneCircle.layer.cornerRadius = partOneCircle.frame.width/2
        partOneCircle.layer.masksToBounds = true
        partTwoCircle.layer.cornerRadius = partTwoCircle.frame.width/2
        partTwoCircle.layer.masksToBounds = true
    
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
}
