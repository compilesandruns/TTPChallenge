//
//  CreateUserInteracting.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit

protocol CreateUserInteracting {
    func createUser(email:String, password: String) -> Promise<String>
}
