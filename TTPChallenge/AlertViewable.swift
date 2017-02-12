//
//  File.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PromiseKit

enum AlertButtonStyle {
    case Default, Cancel, Destructive
}

protocol AlertViewable {
    func showAlert(message: String, title: String?) -> Promise<Void>
//    func showErrorAlert(error: Error) -> Promise<Void>
    func showDecisionAlert(message: String, title: String?, okButtonTitle: String?, cancelButtonTitle: String?) -> Promise<Bool>
    func showDecisionAlert(message: String, title: String?, okButtonTitle: String?, okButtonStyle: AlertButtonStyle, cancelButtonTitle: String?, cancelButtonStyle: AlertButtonStyle) -> Promise<Bool>
}
