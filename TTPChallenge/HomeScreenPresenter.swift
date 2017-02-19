//
//  HomeScreenPresenter.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

class HomeScreenPresenter {
    unowned let view: HomeScreenViewable
    
    init(view: HomeScreenViewable) {
        self.view = view
    }
}

extension HomeScreenPresenter: HomeScreenPresenting {
    func viewDidLoad() {
        
    }
}

extension HomeScreenPresenter: MenuDelegate {
    func menuWillAppear() {
    
    }
    
    func menuDidAppear() {
        
    }
    
    func menuWillDisappear() {
        
    }
    
    func menuDidDisappear() {
        
    }
    
    func showLoginFlow() {
        view.showLoginFlow()
    }
    
    func showQuizFlow() {
        view.showQuizFlow()
    }
    
    func showSuggestedEventsFlow() {
        view.showSuggestedEventsFlow()
    }
    
    func showSavedEventsFlow() {
        view.showSavedEventsFlow()
    }
    
    func showChatFlow() {
        view.showChatFlow()
    }
    
    func showWebView(url: String) {
        view.showWebView(url: url)
    }
}
