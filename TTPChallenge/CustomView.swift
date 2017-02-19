//
//  CustomView.swift
//  TTPChallenge
//
//  Created by Mirim An on 2/18/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}



