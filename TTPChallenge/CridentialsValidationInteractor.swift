//
//  SignInValidationInteracting.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

class CridentialsValidationInteractor {
    
    func isValidEmail(email: String) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", Environment.Validation.namePattern).evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", Environment.Validation.emailPattern).evaluate(with: password)
    }
    
    func isSignUpComplete(name: String, email: String, password: String) -> Bool {
        return !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isLoginComplete(email: String, password: String) -> Bool {
        return !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension CridentialsValidationInteractor: CridentialsValidationInteracting {
        
    func validateCridentials(email: String, password: String) -> String? {
        
        if !isLoginComplete(email: email, password: password) {
            return "Please provide a valid email address and password"
        }
        var errorMessage: [String] = []

        if !isValidEmail(email: email) {
            errorMessage.append("email address")
        }
        if !isValidPassword(password: password) {
            errorMessage.append("password with a minimum of 8 characters at least 1 letter and 1 number")
        }
        
        if errorMessage.count > 1 {
            errorMessage[errorMessage.count - 1] = String(format: "and \(errorMessage.last!)")
        }
        if (errorMessage.count == 2) {
            return String(format: "Please supply a valid \(errorMessage.joined(separator: " "))")
        }
        if errorMessage.count > 0 {
            return "Please supply a valid \(errorMessage.joined(separator: ", "))"
        }
        return nil
    }
}
