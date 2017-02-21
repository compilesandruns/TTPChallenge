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
    var memoryCacheDataStore: MemoryCacheDataStoring
    
    init(firebaseInteractor: FirebaseInteracting, cridentialsValidationInteractor: CridentialsValidationInteracting, memoryCacheDataStore: MemoryCacheDataStoring) {
        self.firebaseInteractor = firebaseInteractor
        self.cridentialsValidationInteractor = cridentialsValidationInteractor
        self.memoryCacheDataStore = memoryCacheDataStore
    }
    
    func signIn(email: String, password: String) -> Promise<FIRUser> {
        return cridentialsValidationInteractor.validateSignIn(email: email, password: password)
            .then { _ in
                return self.firebaseInteractor.signIn(email: email, password: password).then { user -> Promise<FIRUser> in
                    
                    Environment.Firebase.ref.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                        let username = value?["username"] as? String ?? ""
                        self.memoryCacheDataStore.user = User.init(username: username)
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    return Promise(value: user)
                }
            }
    }
    
}
