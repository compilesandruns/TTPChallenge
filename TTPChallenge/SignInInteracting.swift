//
//  LoginInteracting.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit

protocol SignInInteracting {
//    func createUser(email:String, password: String) -> Promise<String>
    func signIn(email: String, password: String) -> Promise<Void>
}
