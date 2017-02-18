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
    
    func setupMenuSections() {
        var sections = [MenuSection]()
        
        var discoverSection = MenuSection()
        discoverSection.type = .Discover
        discoverSection.name = "Discover"
    
        var retakeButton = MoreInformationButton()
        retakeButton.type = .RetakeTheQuiz
        retakeButton.name = "Retake the Quiz"
    
        discoverSection.buttons.append(retakeButton)
        sections.append(discoverSection)
        
        var connectSection = MenuSection()
        connectSection.type = .Connect
        connectSection.name = "Connect"
        
        var techTalkButton = MoreInformationButton()
        techTalkButton.type = .TechTalk
        techTalkButton.name = "Tech Talk"
        connectSection.buttons.append(techTalkButton)
        
        sections.append(connectSection)
        
        var learnSection = MenuSection()
        learnSection.type = .Learn
        learnSection.name = "Learn"
        
        var aboutButton = MoreInformationButton()
        aboutButton.type = .AboutTTP
        aboutButton.name = "About TTP"
        
        var learnMoreButton = MoreInformationButton()
        learnMoreButton.type = .LearnMore
        learnMoreButton.name = "Learn More"

        learnSection.buttons.append(aboutButton)
        learnSection.buttons.append(learnMoreButton)
        sections.append(learnSection)
        
        view.setMenuSections(sections: sections)
    }
}

extension MenuPresenter: MenuPresenting {
    func viewWillAppear() {
        delegate?.menuWillAppear()
    
        setupMenuSections()
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
