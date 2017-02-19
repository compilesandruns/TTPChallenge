//
//  SignInValidationInteracting.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit

class CridentialsValidationInteractor {
    
    func isValidEmail(email: String) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", Environment.Validation.emailPattern).evaluate(with: email)
    }
    
    func isEmailProvided(email: String) -> Bool {
        return !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isValidPassword(password: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", Environment.Validation.passwordPattern).evaluate(with: password)
    }
    
    func isPasswordProvided(password: String) -> Bool {
        return !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func isUsernameValid(username: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", Environment.Validation.usernamePattern).evaluate(with: username)
    }
    
    func isUsernameProvided(username: String) -> Bool {
        return !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension CridentialsValidationInteractor: CridentialsValidationInteracting {
    func validateSignIn(email: String, password: String) -> Promise<Void> {
        
        var errorMessage: [String] = []
        var missingMessage: [String] = []
        
        if !isValidEmail(email: email) {
            errorMessage.append("email address")
        }
        
        if !isEmailProvided(email: email) {
            missingMessage.append("email")
        }
        
        if !isValidPassword(password: password) {
            errorMessage.append("password with a minimum of 8 characters at least 1 letter and 1 number")
        }
        if !isPasswordProvided(password: password) {
            missingMessage.append("password")
        }
        
        var errorString: String?
        var missingString: String?
        if errorMessage.count == 2 {
            errorMessage[errorMessage.count - 1] = String(format: "and \(errorMessage.last!)")
        }
        if errorMessage.count > 0 {
            errorString =  String(format: "Please supply a valid \(errorMessage.joined(separator: " "))")
        }
        
        if missingMessage.count == 2 {
            missingMessage[missingMessage.count - 1] = String(format: "and \(missingMessage.last!)")
        }
        if missingMessage.count > 0 {
            missingString =  String(format: "\(missingMessage.joined(separator: " ")) are required fields")
        }
        
        let errors = [missingString, errorString].flatMap{$0}
        if errors.count > 0 {
            return Promise(error: ValidationError(errors:errors))
        }
        return Promise(value:())
    }
    
    func validateSignUp(email: String, password: String, username: String) -> Promise<Void> {
        var errorMessage: [String] = []
        var missingMessage: [String] = []
        
        if !isValidEmail(email: email) {
            errorMessage.append("email address")
        }
        
        if !isEmailProvided(email: email) {
            missingMessage.append("email")
        }
        
        if !isValidPassword(password: password) {
            errorMessage.append("password with a minimum of 8 characters at least 1 letter and 1 number")
        }
        if !isPasswordProvided(password: password) {
            missingMessage.append("password")
        }
        
        if !isUsernameValid(username: username) {
            errorMessage.append("username")
        }
        
        if !isUsernameProvided(username: username) {
            missingMessage.append("username")
        }
        
        var errorString: String = ""
        var missingString = ""
        if errorMessage.count >= 2 {
            errorMessage[errorMessage.count - 1] = String(format: "and \(errorMessage.last!)")
        }
        if errorMessage.count > 0 {
            errorString =  String(format: "Please supply a valid \(errorMessage.joined(separator: " "))")
        }
        
        if missingMessage.count >= 2 {
            missingMessage[missingMessage.count - 1] = String(format: "and \(missingMessage.last!)")
        }
        if missingMessage.count > 0 {
            missingString =  String(format: "\(missingMessage.joined(separator: " ")) are required fields")
        }
        
        let errors = [missingString, errorString].flatMap{$0}
        if errors.count > 0 {
            return Promise(error: ValidationError(errors:errors))
        }
        return Promise(value:())
    }
}
