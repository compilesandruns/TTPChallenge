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
        
        var retakeButton = MoreInformationButton()
        retakeButton.type = .RetakeTheQuiz
        retakeButton.name = "Retake the Quiz"
        buttons.append(retakeButton)

        var techTalkButton = MoreInformationButton()
        techTalkButton.type = .TechTalk
        techTalkButton.name = "Tech Talk"
        buttons.append(techTalkButton)
        
        var aboutButton = MoreInformationButton()
        aboutButton.type = .AboutTTP
        aboutButton.name = "About TTP"
        buttons.append(aboutButton)
        
        var learnMoreButton = MoreInformationButton()
        learnMoreButton.type = .LearnMore
        learnMoreButton.name = "Learn More"
        buttons.append(learnMoreButton)
        
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
            case .RetakeTheQuiz:
                self.delegate?.showWebView(url: "www.google.com")
            case .TechTalk:
                self.delegate?.showWebView(url: "www.google.com")
            case .AboutTTP:
                self.delegate?.showWebView(url: "www.google.com")
            case .LearnMore:
                self.delegate?.showWebView(url: "www.google.com")
            }
        }
    }
    
    func logoutButtonTapped() {
        //TODO: Firebase Interactor logout
        view.showLoginFlow()
        
    }
}
