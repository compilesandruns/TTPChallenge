//
//  HomeScreenViewable.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

protocol HomeScreenViewable: class {
    func openMenu()
    func closeMenu()
    
    func showWebView(url: String)
    func showLoginFlow()
    func showQuizFlow()
    func showSuggestedEventsFlow()
    func showSavedEventsFlow()
    func showProfileScreen()
    
    func showLoader()
    func hideLoader()
}
