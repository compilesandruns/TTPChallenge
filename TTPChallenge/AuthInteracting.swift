//
//  AuthInteracting.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation
import PromiseKit

protocol AuthInteracting: class {
    var isLoggedIn: Bool { get }
    func logout() -> Promise<Void>
}
