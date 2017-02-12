//
//  LoginPresenter.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

class SignInScreenPresenter: SignInScreenPresenting {
    unowned let view: SignInScreenViewable
    
    let signInInteractor: SignInInteracting
    
    init(view: SignInScreenViewable, signInInteractor: SignInInteracting) {
        self.view = view
        self.signInInteractor = signInInteractor
    }
    
    func didTapLogin() {
        let errorMessage = signInInteractor.signIn(email: view.email, password: view.password)
        if !errorMessage.isEmpty {
            
        }
        
    }
    
    func didTapSignUp() {
    }
    
    func didBeginEditingEmail() {
        
    }
    func didFinishEditingEmail() {
        
    }
    func didBeginEditingPassword() {
        
    }
    func didFinishEditingPassword() {
        
    }
}
