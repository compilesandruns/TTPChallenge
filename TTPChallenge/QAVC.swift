//
//  QAVC.swift
//  TTPChallenge
//
//  Created by Luna An on 2/14/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class QAVC: UIViewController {
    
    @IBOutlet var informationButtons: [UIButton]!
    
    @IBOutlet weak var retakeQuizButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // button styling
        for button in informationButtons {
            button.layer.cornerRadius = 12
        }
        retakeQuizButton.layer.cornerRadius = 20

    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        print("sharebuttontapped")
        // implement activity view controller
        // share via social networks?
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToQuizMain", sender: self)
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

    
    
    @IBAction func retakeQuizBtnTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "backHome", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
