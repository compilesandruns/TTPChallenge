//
//  AuthInteractor.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation
import PromiseKit

class AuthInteractor: AuthInteracting {
    
    init() {

    }
    
    var isLoggedIn: Bool {
        
        return true
    }
    
    func logout() -> Promise<Void> {
        return Promise(value:())
    }
}
