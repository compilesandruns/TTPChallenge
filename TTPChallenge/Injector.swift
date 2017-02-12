//
//  Injector.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

class Injector {
    private static var injector: Injector!

    var firebaseInteractor: FirebaseInteracting!
    var signInInteractor: SignInInteracting!
    var signInValidationInteractor: SignInValidationInteracting!
    
    static var currentInjector: Injector {
        return injector
    }

    init() {
        firebaseInteractor = FirebaseInteractor()
        signInInteractor = SignInInteractor(firebaseInteractor:firebaseInteractor, signInValidationInteractor: signInValidationInteractor)
        signInValidationInteractor = SignInValidationInteractor()
    }
    
    func signInScreenPresenter(view: SignInScreenViewable) -> SignInScreenPresenter {
        return signInScreenPresenter(view: view)
    }
}
