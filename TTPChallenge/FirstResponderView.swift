//
//  FirstResponderView.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

extension UIView  {
    
    func firstResponder() -> UIView? {
        if self.isFirstResponder{
            return self
        }
        
        for view in self.subviews {
            if let firstResponder = view.firstResponder() {
                return firstResponder
            }
        }
        return nil
    }
}
