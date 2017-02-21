//
//  FirebaseInteracting.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit
import FirebaseAuth

protocol FirebaseInteracting {    
    func createUser(email:String, password: String) -> Promise<FIRUser>
    func signIn(email: String, password: String) -> Promise<FIRUser>
    func getCurrentUser() -> Promise<User?>
}
