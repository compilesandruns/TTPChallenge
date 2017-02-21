//
//  MenuDelegate.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

protocol MenuDelegate: class {
    func menuWillAppear()
    func menuDidAppear()
    func menuWillDisappear()
    func menuDidDisappear()
    
    func showWebView(url: String)
    func showLoginFlow()
    func showQuizFlow()
    func showSuggestedEventsFlow()
    func showSavedEventsFlow()
    func showChatFlow()
    func showSuggeestedCoursesFlow()
}
