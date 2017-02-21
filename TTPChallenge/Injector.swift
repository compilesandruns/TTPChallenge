//
//  Injector.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

class Injector: BaseInjector {
    private static var injector: Injector!
    
    static var currentInjector: BaseInjector {
        return injector
    }
    
    static func setInjector(injector: Injector) {
        self.injector = injector
    }

    override init() {
        super.init()
        
        memoryCacheDataStore = MemoryCacheDataStore()
        firebaseInteractor = FirebaseInteractor()
        cridentialsValidationInteractor = CridentialsValidationInteractor()
        createUserInteractor = CreateUserInteractor(firebaseInteractor:firebaseInteractor, cridentialsValidationInteractor: cridentialsValidationInteractor)
        signInInteractor = SignInInteractor(firebaseInteractor:firebaseInteractor, cridentialsValidationInteractor: cridentialsValidationInteractor, memoryCacheDataStore: memoryCacheDataStore)
    }
}
