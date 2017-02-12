//
//  LoginValidationInteractor.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

protocol CridentialsValidationInteracting {
    func validateCridentials(email: String, password: String) -> String?

}
