//
//  AllTechTypesVC.swift
//  TTPChallenge
//
//  Created by Mirim An on 2/15/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class AllTechTypesVC: UIViewController {

    @IBOutlet var allTechJobsButtons: [UIButton]!
    
    @IBOutlet weak var retakeQuizButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        // segue based on the index value
        
        
        
    }
    
    @IBAction func retakeQuizBtnTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "backHomeFromAllType", sender: self)
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
