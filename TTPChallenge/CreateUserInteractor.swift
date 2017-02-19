//
//  CreateUserInteractor.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit

class CreateUserInteractor: CreateUserInteracting {
    let firebaseInteractor: FirebaseInteracting
    let cridentialsValidationInteractor: CridentialsValidationInteracting
    
    init(firebaseInteractor: FirebaseInteracting, cridentialsValidationInteractor: CridentialsValidationInteracting) {
        self.firebaseInteractor = firebaseInteractor
        self.cridentialsValidationInteractor = cridentialsValidationInteractor
    }
    
    func createUser(email:String, password: String, username: String) -> Promise<Void> {
        return cridentialsValidationInteractor.validateSignUp(email: email, password: password, username: username).then { _ -> Void in
            return self.firebaseInteractor.createUser(email: email, password: password).then { _  -> Void in
                if let user = FIRAuth.auth()?.currentUser {
                    Environment.Firebase.ref.child("users").child(user.uid).setValue(["username": username])
                }
            }
        }
    }
}
