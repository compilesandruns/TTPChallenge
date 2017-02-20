//
//  CustomTextfield.swift
//  TTPChallenge
//
//  Created by Mirim An on 2/19/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

@IBDesignable class CustomTextfield: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
