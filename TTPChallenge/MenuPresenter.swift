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
        
        //Discover
        var discoverSection = MenuSection()
        discoverSection.type = .Discover
        discoverSection.name = "Discover"
    
        var retakeButton = MoreInformationButton()
        retakeButton.type = .TakeTheQuiz
        retakeButton.name = "Take the Quiz"
    
        discoverSection.buttons.append(retakeButton)
        sections.append(discoverSection)
        
        //Connect
        var connectSection = MenuSection()
        connectSection.type = .Connect
        connectSection.name = "Connect"
        
        var techTalkButton = MoreInformationButton()
        techTalkButton.type = .TechTalk
        techTalkButton.name = "Tech Talk"
        connectSection.buttons.append(techTalkButton)
        
        var attendButton = MoreInformationButton()
        attendButton.type = .TechTalk
        attendButton.name = "Attend An Event"
        connectSection.buttons.append(attendButton)
        
        sections.append(connectSection)
        
        //Learn
        var learnSection = MenuSection()
        learnSection.type = .Learn
        learnSection.name = "Learn"
        
        var aboutButton = MoreInformationButton()
        aboutButton.type = .AboutTTP
        aboutButton.name = "About TTP"
        
        var meetButton = MoreInformationButton()
        meetButton.type = .MeetThePipeline
        meetButton.name = "Meet The Pipeline"
        learnSection.buttons.append(meetButton)
        
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
            case .TakeTheQuiz:
                self.delegate?.showQuizFlow()
            case .TechTalk:
                //TODO: change to showChatFlow()
                self.delegate?.showWebView(url: "http://www.google.com")
            case .AttendAnEvent:
                self.delegate?.showSuggestedEventsFlow()
            case .MyEvents:
                self.delegate?.showSavedEventsFlow()
            case .MyProfile:
                self.delegate?.showProfileScreen()
            case .MeetThePipeline:
                self.delegate?.showWebView(url: Environment.Path.meetThePipeline)
            case .AboutTTP:
                self.delegate?.showWebView(url: Environment.Path.aboutTTP)
            case .LearnMore:
                self.delegate?.showWebView(url: Environment.Path.learnMore)
            }
        }
    }
    
    func logoutButtonTapped() {
        //TODO: Firebase Interactor logout
        self.delegate?.showLoginFlow()
    }
}
