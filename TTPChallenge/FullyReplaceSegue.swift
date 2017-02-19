//
//  FullyReplaceSegue.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class FullyReplaceSegue: UIStoryboardSegue {
    override func perform() {
        self.source.dismiss(animated: false, completion: nil)
        UIApplication.shared.keyWindow?.rootViewController = self.destination
    }
}
