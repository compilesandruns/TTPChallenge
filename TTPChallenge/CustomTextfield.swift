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
    @IBInspectable var paddingLeft: CGFloat = 10.0
    @IBInspectable var paddingRight: CGFloat = 10.0

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight)))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight)))
    }
}
