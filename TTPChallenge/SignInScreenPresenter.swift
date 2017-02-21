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
        signInInteractor.signIn(email: view.email, password: view.password)
            .then { user -> Void in
                    self.view.hideLoader()
                    self.view.showHomeScreen()

            }
            .catch { error -> Void in
                self.view.hideLoader()
                if let errCode = FIRAuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .errorCodeUserNotFound:
                        self.view.showAlert(message:Environment.Alert.userNotFound, title: Environment.Alert.errorTitle)
                    default:
                        break
                    }
                }
                
                if let err = error as? ValidationError, err.errors.count > 0 {
                    self.view.showAlert(message: (error as! ValidationError).displayMessage, title: (error as! ValidationError).displayTitle)
                } else {
                    self.view.showAlert(message:Environment.Alert.defaultError, title: Environment.Alert.errorTitle)
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
