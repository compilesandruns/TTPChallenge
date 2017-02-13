//
//  MenuPresenter.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation

class MenuPresenter {
    unowned let view: MenuViewable
    
    var delegate: MenuDelegate?
    let authInteractor: AuthInteracting
    let demoModeInteractor: DemoModeInteracting
    let localKeyValueDataStore: JSONKeyValueDataStoring
    
    init(view: MenuViewable, delegate: MenuDelegate?, membershipInteractor: MembershipInteracting, authInteractor: AuthInteracting, memoryCacheDataStore: MemoryCacheDataStoring, demoModeInteractor: DemoModeInteracting, localKeyValueDataStore: JSONKeyValueDataStoring) {
        self.view = view
        self.delegate = delegate
        self.membershipInteractor = membershipInteractor
        self.authInteractor = authInteractor
        self.memoryCacheDataStore = memoryCacheDataStore
        self.demoModeInteractor = demoModeInteractor
        self.localKeyValueDataStore = localKeyValueDataStore
    }
    
    func setupMoreInformationButtons() {
        var buttons = [MoreInformationButton]()
        
        if demoModeInteractor.isDemoMode && FeatureFlags.hasJoinOurCommunityButton {
            var button = MoreInformationButton()
            button.type = .JoinOurCommunity
            button.name = "Join Our Community"
            buttons.append(button)
        }
        
        var aboutPhoneButton = MoreInformationButton()
        aboutPhoneButton.type = .AboutMyPhone
        aboutPhoneButton.name = "About My Phone"
        buttons.append(aboutPhoneButton)
        
        var termsButton = MoreInformationButton()
        termsButton.type = .TermsOfService
        termsButton.name = "Terms Of Service"
        buttons.append(termsButton)
        
        var privacyButton = MoreInformationButton()
        privacyButton.type = .PrivacyPolicy
        privacyButton.name = "Privacy Policy"
        buttons.append(privacyButton)
        
        var aboutLSButton = MoreInformationButton()
        aboutLSButton.type = .AboutLegalShield
        aboutLSButton.name = "About LegalShield"
        buttons.append(aboutLSButton)
        
        view.setMoreInformationButtons(buttons)
    }
}

extension MenuPresenter: MenuPresenting {
    func viewWillAppear() {
        delegate?.menuWillAppear()
    
        setupMoreInformationButtons()
    }
    
    func viewDidAppear() {
        delegate?.menuDidAppear()
    }
    
    func viewWillDisappear() {
        delegate?.menuWillDisappear()
    }
    
    func viewDidDisappear() {
        delegate?.menuDidDisappear()
    }
    
    func didTapMoreInformationButton(button: MoreInformationButton) {
        view.closeMenuForModal().then { _ -> Void in
            switch button.type! {
            case .JoinOurCommunity:
                var purchasePath = Environment.App.purchasePathLink
                if let associateNumber = self.localKeyValueDataStore.get(Environment.Branch.associateNumberKey) {
                    purchasePath += "&\(Environment.Branch.associateNumberParamKey)=\(associateNumber)"
                }
                self.delegate?.showWebView(purchasePath)
            case .AboutMyPhone:
                self.delegate?.showAboutMyPhoneScreen()
            case .TermsOfService:
                self.delegate?.showWebView(Environment.Web.termsOfServiceLink)
            case .PrivacyPolicy:
                self.delegate?.showWebView(Environment.Web.privacyPolicyLink)
            case .AboutLegalShield:
                self.delegate?.showWebView(Environment.Web.aboutLegalShieldLink)
            }
        }
    }
    
    func logoutButtonTapped() {
        authInteractor.logout().always {
            view.showLoginFlow()
        }
    }
}
