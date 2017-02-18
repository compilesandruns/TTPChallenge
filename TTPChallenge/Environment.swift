//
//  Environment.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/9/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

struct Environment {
    
    struct Colors {
        //In order from lightest to darkest
        static let primaryBlue = UIColor(red: 0/255, green: 152/255, blue: 238/255, alpha: 1)
        static let secondaryBlue = UIColor(red: 0/255, green: 105/255, blue: 167/255, alpha: 1)
        static let tertiaryBlue = UIColor(red: 0/255, green: 82/255, blue: 130/255, alpha: 1)
        static let primaryBlack = UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1)
        
    }
    
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
    
    struct Path {
        static let meetThePipeline = "http://ttp.nyc/show-blog/"
        static let aboutTTP = "http://www.techtalentpipeline.nyc/"
        static let learnMore = "http://www.techtalentpipeline.nyc/contact-us-1/"
    }
}
