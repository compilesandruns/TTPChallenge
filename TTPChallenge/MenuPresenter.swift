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
        //My TTP
        var myTTPSection = MenuSection()
        myTTPSection.type = .MyTTP
        myTTPSection.name = "My TTP"
        
        var myEventsButton = MoreInformationButton()
        myEventsButton.type = .MyEvents
        myEventsButton.name = "My Favs"
        myTTPSection.buttons.append(myEventsButton)
        
        sections.append(myTTPSection)
        
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
        attendButton.type = .AttendAnEvent
        attendButton.name = "Join a Community"
        connectSection.buttons.append(attendButton)
        
        sections.append(connectSection)
        
        //Learn
        var learnSection = MenuSection()
        learnSection.type = .Learn
        learnSection.name = "Learn"
        
        var courseButton = MoreInformationButton()
        courseButton.type = .FreeCourse
        courseButton.name = "Free Courses"
        
        var aboutButton = MoreInformationButton()
        aboutButton.type = .AboutTTP
        aboutButton.name = "About TTP"
        
        var meetButton = MoreInformationButton()
        meetButton.type = .MeetThePipeline
        meetButton.name = "Meet the Pipeline"
        
        var learnMoreButton = MoreInformationButton()
        learnMoreButton.type = .LearnMore
        learnMoreButton.name = "Learn More"

        learnSection.buttons.append(courseButton)
        learnSection.buttons.append(meetButton)
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
            case .MyEvents:
                self.delegate?.showSavedEventsFlow()
            
            case .TakeTheQuiz:
                self.delegate?.showQuizFlow()
            
            case .TechTalk:
                self.delegate?.showChatFlow()
            case .AttendAnEvent:
                self.delegate?.showSuggestedEventsFlow()
            
            case .MyEvents:
                self.delegate?.showSavedEventsFlow()
            
            case .MeetThePipeline:
                self.delegate?.showWebView(url: Environment.Path.meetThePipeline)
            
            case .AboutTTP:
                self.delegate?.showWebView(url: Environment.Path.aboutTTP)
            
            case .LearnMore:
                self.delegate?.showWebView(url: Environment.Path.learnMore)
            case .FreeCourse:
                self.delegate?.showSuggeestedCoursesFlow()
            }
            
        }
    }
    
    func logoutButtonTapped() {
        //TODO: Firebase Interactor logout
        self.delegate?.showLoginFlow()
    }
}
