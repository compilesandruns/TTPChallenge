//
//  BaseInjector.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

class BaseInjector {
    
    init() {
    
    }
    //Interactors
    var firebaseInteractor: FirebaseInteracting! = nil
    var signInInteractor: SignInInteracting! = nil
    var cridentialsValidationInteractor: CridentialsValidationInteracting! = nil
    var createUserInteractor: CreateUserInteracting! = nil
    
    func signInScreenPresenter(view: SignInScreenViewable) -> SignInScreenPresenter {
        return SignInScreenPresenter(view: view, signInInteractor: signInInteractor)
    }
    
    func createUserScreenPresenter(view: CreateUserScreenViewable) -> CreateUserScreenPresenter {
        return CreateUserScreenPresenter(view: view, createUserInteractor: createUserInteractor )
    }
}
