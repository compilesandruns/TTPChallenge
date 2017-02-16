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
        view.showLoader()
        signInInteractor.signIn(email: view.email, password: view.password).then{ errorMessage -> Void in
            if !errorMessage.isEmpty {
                self.view.hideLoader()
                self.view.showAlert(message: errorMessage, title: Environment.Alert.errorTitle)
            } else {
                self.view.showHomeScreen()
            }
        }.catch { error in
            self.view.hideLoader()
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
    
    func didTapBackground() {
        view.dismissKeyboard()
    }
    
    func didTapSignUp() {
        view.showSignUpScreen()
    }
}
