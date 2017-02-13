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
    
    struct Validation {
        static let namePattern = "^[\\w][\\w\\s.-]*$"
        static let emailPattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]+$"
        static let passwordPattern = "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z[0-9]]{8,}$"
    }
    struct Alert {
        static let errorTitle = "Whoops!"
        static let invalidEmail = "Invalid email. Please enter a valid email address"
        static let emailInUse = "Email already in use. Please sign in."
        static let defaultError = "An error has occured. Please try again later."
        static let userNotFound = "Unable to locate account. Please create a new account."
    }
}
