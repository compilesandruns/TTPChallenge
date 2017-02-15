//
//  MenuPresenter.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

class MenuPresenter {
    unowned let view: MenuViewable    
    var delegate: MenuDelegate?
    
    init(view: MenuViewable, delegate: MenuDelegate?) {
        self.view = view
        self.delegate = delegate
    }
    
    func setupMoreInformationButtons() {
        var buttons = [MoreInformationButton]()
        
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
        
        view.setMoreInformationButtons(buttons: buttons)
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
                self.delegate?.showWebView(url: "www.google.com")
            case .AboutMyPhone:
                self.delegate?.showWebView(url: "www.google.com")
            case .TermsOfService:
                self.delegate?.showWebView(url: "www.google.com")
            case .PrivacyPolicy:
                self.delegate?.showWebView(url: "www.google.com")
            case .AboutLegalShield:
                self.delegate?.showWebView(url: "www.google.com")
            }
        }
    }
    
    func logoutButtonTapped() {
        //TODO: Firebase Interactor logout
        view.showLoginFlow()
        
    }
}
