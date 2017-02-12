//
//  LoginPresenter.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit
import FirebaseAuth

class SignInScreenPresenter: SignInScreenPresenting {
    unowned let view: SignInScreenViewable
    
    let signInInteractor: SignInInteracting
    
    init(view: SignInScreenViewable, signInInteractor: SignInInteracting) {
        self.view = view
        self.signInInteractor = signInInteractor
    }
    
    //TODO: add error handling
    func didTapLogin() {
        signInInteractor.signIn(email: view.email, password: view.password).then{ errorMessage -> Void in
            if !errorMessage.isEmpty {
                self.view.showAlert(message: errorMessage, title: Environment.Alert.errorTitle)
            }
        }.catch { error in
            if let errCode = FIRAuthErrorCode(rawValue: error._code) {
                
            switch errCode {
                case .errorCodeUserNotFound:
                    self.view.showAlert(message:Environment.Alert.userNotFound, title: Environment.Alert.errorTitle)
                default:
                    self.view.showAlert(message:Environment.Alert.defaultError , title: Environment.Alert.errorTitle)
                        
                    }    
                }
        }

    }
    
    func didTapSignUp() {
        view.openSignUpScreen()
    }
}
