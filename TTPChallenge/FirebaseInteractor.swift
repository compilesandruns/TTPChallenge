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
    
    func getCurrentUser() -> Promise<User?> {
        var user: User?
        let userID = FIRAuth.auth()?.currentUser?.uid
        Environment.Firebase.ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            user = User.init(username: username)
        }) { (error) in
            print(error.localizedDescription)
        }
        return Promise(value: user)
    }
}

