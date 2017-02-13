//
//  MenuPresenting.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

protocol MenuPresenting {
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    
    func didTapMoreInformationButton(button: MoreInformationButton)
    func didTapLogoutButton()
}
