//
//  ViewController.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/9/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class SignInScreenViewController: BaseViewController {
    
    var presenter: SignInScreenPresenting!
    
    var signInInteractor: SignInInteracting!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Injector.currentInjector.signInScreenPresenter(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginTapped(_ sender: Any) {
        presenter.didTapLogin()
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        presenter.didTapSignUp()
    }
    
    @IBAction func emailEditingBegun(_ sender: Any) {
        presenter.didBeginEditingEmail()
    }
    
    
    @IBAction func emailEditingEnded(_ sender: Any) {
        presenter.didFinishEditingEmail()
    }
    
    @IBAction func passwordEditingBegun(_ sender: Any) {
        presenter.didBeginEditingPassword()
    }
    
    
    @IBAction func passwordEditingEnded(_ sender: Any) {
        presenter.didFinishEditingPassword()
    }

}
extension SignInScreenViewController : SignInScreenViewable {
    
    var email: String {
        set {
            emailField.text = newValue
        }
        get {
            return emailField.text ?? ""
        }
    }
    
    var password: String {
        set {
            passwordField.text = newValue
        }
        get {
            return passwordField.text ?? ""
        }
    }
    
    func tintEmailFieldRed() {
        emailField.layer.borderColor = UIColor.red.cgColor
    }
    
    func tintEmailFieldDefault() {
        emailField.layer.borderColor = UIColor.clear.cgColor
    }
    
    func tintPasswordFieldRed() {
        passwordField.layer.borderColor = UIColor.red.cgColor
    }
    
    func tintPasswordFieldDefault() {
        passwordField.layer.borderColor = UIColor.clear.cgColor
    }
    
}

