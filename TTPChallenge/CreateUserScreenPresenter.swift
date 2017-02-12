//
//  CreateUserScreenPresenter.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import FirebaseAuth

class CreateUserScreenPresenter: CreateUserScreenPresenting {
    unowned let view: CreateUserScreenViewable
    
    var createUserInteractor: CreateUserInteracting
    
    init(view: CreateUserScreenViewable, createUserInteractor: CreateUserInteracting) {
        self.view = view
        self.createUserInteractor = createUserInteractor
    }
    func didTapCloseButton() {
        view.dismissView()
    }
    
    func didTapGetStartedButton() {
        createUserInteractor.createUser(email: view.email, password: view.password).then{ errorMessage -> Void in
            if !errorMessage.isEmpty {
                self.view.showAlert(message: errorMessage, title: Environment.Alert.errorTitle)
            }
        }.catch { error in
            if let errCode = FIRAuthErrorCode(rawValue: error._code) {
                
                switch errCode {
                case .errorCodeInvalidEmail:
                    self.view.showAlert(message:Environment.Alert.invalidEmail, title: Environment.Alert.errorTitle)
                case .errorCodeEmailAlreadyInUse:
                    self.view.showAlert(message: Environment.Alert.emailInUse, title:Environment.Alert.errorTitle)
                default:
                    self.view.showAlert(message:Environment.Alert.defaultError , title: Environment.Alert.errorTitle)

                }    
            }
        }
    }
}
