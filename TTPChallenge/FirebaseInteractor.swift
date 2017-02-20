//
//  FirebaseInteractor.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//
import PromiseKit
import FirebaseAuth

class FirebaseInteractor: FirebaseInteracting {
    func createUser(email:String, password: String) -> Promise<FIRUser> {
        return FIRAuth.auth()!.createUser(withEmail: email, password: password, completion: nil)
    }
    
    func signIn(email: String, password: String) -> Promise<FIRUser> {
        return FIRAuth.auth()!.signIn(withEmail: email, password: password, completion: nil)
    }
    
    func setUsername(username: String) -> Promise<String> {
        guard let user = FIRAuth.auth()!.currentUser else {
            return Promise(value: "")

//            return Promise(error: ValidationError(error: ))
        }
       let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = username
        
        changeRequest.commitChanges { error in

        }
        return Promise(value: "")
    }
}

