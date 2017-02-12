//
//  LoginValidationInteractor.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

protocol SignInValidationInteracting {
    func validateNewUser(name: String, email: String, password: String) -> String?
    func validateSignIn(email: String, password: String) -> String?

}
