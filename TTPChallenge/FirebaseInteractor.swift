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
    var ref: FIRDatabaseReference!
    
    init() {
        self.ref = FIRDatabase.database().reference()

    }
    
    func createUser(email:String, password: String) -> Promise<FIRUser> {
        return FIRAuth.auth()!.createUser(withEmail: email, password: password, completion: nil)
    }
    
    func signIn(email: String, password: String) -> Promise<FIRUser> {
        return FIRAuth.auth()!.signIn(withEmail: email, password: password, completion: nil)
    }
    
    func setUsername(username: String) {
        guard let user = FIRAuth.auth()!.currentUser else {
            return
        }
        self.ref.child("users").child(user.uid).setValue(["username": username])
    }
}

