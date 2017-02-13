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
    
    func createUser(email:String, password: String) -> Promise<String> {
        if let errorMessage = cridentialsValidationInteractor.validateCridentials(email: email, password: password) {
            return Promise(value: errorMessage)
        }
        return firebaseInteractor.createUser(email: email, password: password).then{ _ -> Promise<String> in
            return Promise(value: "")
        }
    }
}
