//
//  AlertView.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/11/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

//
//  BaseAlertView.swift
//  MyLegalShield
//
//  Created by David Rodriguez on 12/20/16.
//  Copyright © 2016 LegalShield. All rights reserved.
//
import UIKit
import PromiseKit

extension AlertButtonStyle {
    func uiAlertActionStyle() -> UIAlertActionStyle {
        switch self {
        case .Cancel:
            return .cancel
        case .Default:
            return .default
        case .Destructive:
            return .destructive
        }
    }
}

protocol AlertView: AlertViewable {
    var currentMainViewController: UIViewController { get }
}

extension AlertView {
    func showAlert(message: String, title: String?) -> Promise<Void> {
        return Promise { fulfill, reject in
            let alert = PMKAlertController(title: title, message: message)
            alert.addActionWithTitle(title: "Ok")
            currentMainViewController.promise(alert).always {
                fulfill()
            }
        }
    }
    
//    func showErrorAlert(error: Error) -> Promise<Void> {
//        let err = Injector.currentInjector.errorHelper.processError(error)
//        return showAlert(err.displayMessage, title: err.displayTitle)
//    }
    
    func showDecisionAlert(message: String, title: String?, okButtonTitle: String?, cancelButtonTitle: String?) -> Promise<Bool> {
        return showDecisionAlert(message:message, title: title, okButtonTitle: okButtonTitle, okButtonStyle: .Default, cancelButtonTitle: cancelButtonTitle, cancelButtonStyle: .Cancel)
    }
    
    func showDecisionAlert(message: String, title: String?, okButtonTitle: String?, okButtonStyle: AlertButtonStyle, cancelButtonTitle: String?, cancelButtonStyle: AlertButtonStyle) -> Promise<Bool> {
        let okBtn = okButtonTitle ?? "Ok"
        let cancelBtn = cancelButtonTitle ?? "Cancel"
        
        let (promise, fulfill, _) = Promise<Bool>.pending()
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okBtn, style: okButtonStyle.uiAlertActionStyle()) { okAction in
            fulfill(true)
        }
        let cancelAction = UIAlertAction(title: cancelBtn, style: cancelButtonStyle.uiAlertActionStyle()) { cancelAction in
            fulfill(false)
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        currentMainViewController.present(alert, animated: true, completion: nil)
        
        return promise
    }
}
