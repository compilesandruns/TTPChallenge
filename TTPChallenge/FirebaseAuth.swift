//
//  FirebaseAuth.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import FirebaseAuth
import PromiseKit

extension FIRAuth {
    
    func createUser(withEmail email: String, password: String, completion: FirebaseAuth.FIRAuthResultCallback? = nil) -> Promise<FIRUser> {
        return PromiseKit.wrap{ resolve in
                createUser(withEmail: email, password: password, completion: resolve)
            }
    }

    
    func signIn(withEmail email: String, password: String, completion: FirebaseAuth.FIRAuthResultCallback?) -> Promise<FIRUser> {
        return PromiseKit.wrap{ resolve in
            signIn(withEmail: email, password: password, completion: resolve)
        }
    }
    
}
