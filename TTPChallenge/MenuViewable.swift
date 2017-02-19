//
//  MenuViewable.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit

protocol MenuViewable: class {
    func setName(name: String)

    func setMenuSections(sections: [MenuSection])
    
    func closeMenuForModal() -> Promise<Void>
    func closeMenu() -> Promise<Void>
    
    func showLoginFlow()
}
