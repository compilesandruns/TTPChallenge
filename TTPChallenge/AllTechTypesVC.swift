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
