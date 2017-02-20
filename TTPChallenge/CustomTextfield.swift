//
//  CustomTextfield.swift
//  TTPChallenge
//
//  Created by Luna An on 2/19/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

@IBDesignable class CustomTextfield: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.borderColor = Colors.whiteFive.cgColor
        }
    }

}
