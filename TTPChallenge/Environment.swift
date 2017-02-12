//
//  Environment.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/9/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

struct Environment {
    
    struct Firebase {
        static let loginToList = "LoginToList"
    }
    
    struct SignInValidation {
        static let namePattern = "^[\\w][\\w\\s.-]*$"
        static let emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]+$"
        static let passwordPattern = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z[0-9]]{8,}$"
    }
    
}
