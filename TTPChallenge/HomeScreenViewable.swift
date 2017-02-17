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
    
    func showLoginFlow()
    func showWebView(url: String)
    
    func showLoader()
    func hideLoader()
}

