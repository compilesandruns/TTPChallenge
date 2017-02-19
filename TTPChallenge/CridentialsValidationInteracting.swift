//
//  LoginValidationInteractor.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit

protocol CridentialsValidationInteracting {
    func validateSignIn(email: String, password: String) -> Promise<Void>
    func validateSignUp(email: String, password: String, username: String) -> Promise<Void>
}
