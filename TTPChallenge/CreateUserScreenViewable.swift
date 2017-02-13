//
//  CreateUserScreenViewable.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

protocol CreateUserScreenViewable: class, AlertViewable {
    var email: String { set get }
    var password: String { set get }
    
    func dismissView()
    func dismissKeyboard()
}
