//
//  MenuViewable.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit

protocol MenuViewable: class {
    func setMoreInformationButtons(buttons: [MoreInformationButton])
    
    func closeMenuForModal() -> Promise<Void>
    func closeMenu() -> Promise<Void>
    
    func setLogoutButtonTitle(title: String)
    
    func showLoginFlow()
}
