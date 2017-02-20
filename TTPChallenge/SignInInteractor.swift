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
    let cridentialsValidationInteractor: CridentialsValidationInteracting
    
    init(firebaseInteractor: FirebaseInteracting, cridentialsValidationInteractor: CridentialsValidationInteracting) {
        self.firebaseInteractor = firebaseInteractor
        self.cridentialsValidationInteractor = cridentialsValidationInteractor
    }
    
    func signIn(email: String, password: String) -> Promise<FIRUser> {
        return cridentialsValidationInteractor.validateSignIn(email: email, password: password)
            .then { _ in
                return self.firebaseInteractor.signIn(email: email, password: password).then { user -> Promise<FIRUser> in
                    return Promise(value: user)
                }
            }
    }
    
    
}
