//
//  LoginViewable.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

protocol SignInScreenViewable: class, AlertViewable {
    var email: String { set get }
    var password: String { set get }
    
    func dismissKeyboard()
    func showSignUpScreen()
    func showHomeScreen()
}
