//
//  CreateUserScreenViewController.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

class CreateUserScreenViewController: BaseViewController {
    var presenter: CreateUserScreenPresenting!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Injector.currentInjector.createUserScreenPresenter(view:self)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        presenter.didTapCloseButton()
    }
    
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        presenter.didTapGetStartedButton()
    }
    
}

extension CreateUserScreenViewController: CreateUserScreenViewable {
    
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
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
