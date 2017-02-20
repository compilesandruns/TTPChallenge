//
//  CustomButton.swift
//  TTPChallenge
//
//  Created by Luna An on 2/16/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = UIColor.yellow.cgColor
        }
    }
}


