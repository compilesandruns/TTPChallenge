//
//  LoginInteractor.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit

class SignInInteractor: SignInInteracting {
    let firebaseInteractor: FirebaseInteracting
    let signInValidationInteractor: SignInValidationInteracting
    
    init(firebaseInteractor: FirebaseInteracting, signInValidationInteractor: SignInValidationInteracting) {
        self.firebaseInteractor = firebaseInteractor
        self.signInValidationInteractor = signInValidationInteractor
    }
    
//    func createUser(email:String, password: String) -> Promise<String> {
//        if let errorMessage = loginValidationInteractor.
//    }
    func signIn(email: String, password: String) -> Promise<String> {
        if let errorMessage = signInValidationInteractor.validateSignIn(email: email, password: password) {
            return Promise(value: errorMessage)
        }
        return firebaseInteractor.signIn(email: email, password: password).then{ _ -> Promise<String> in
            return Promise(value: "")
        }
    
    }
    
}
