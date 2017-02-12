//
//  LoginPresenting.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

protocol SignInScreenPresenting: class {
    func didTapLogin()
    func didTapSignUp()
    
    func didBeginEditingEmail()
    func didFinishEditingEmail()
    func didBeginEditingPassword()
    func didFinishEditingPassword()

}
