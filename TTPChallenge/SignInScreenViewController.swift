//
//  ViewController.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/9/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit
import PKHUD

class SignInScreenViewController: BaseViewController {
    
    var presenter: SignInScreenPresenting!
        
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Injector.currentInjector.signInScreenPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotifications()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
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
    
    @IBAction func bacgroundTapGestureRecognizer(_ sender: Any) {
        presenter.didTapBackground()
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
    
    func showSignUpScreen() {
        performSegue(withIdentifier: "SignUpSegue", sender: nil)
    }
    
    func showHomeScreen() {
        performSegue(withIdentifier: "HomeScreenSegue", sender: nil)
    }
    
    func showLoader() {
        HUD.show(.progress)
    }

    func hideLoader() {
        HUD.hide()  
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK NotificationCenter
extension SignInScreenViewController {
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(SignInScreenViewController.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: view.window)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignInScreenViewController.keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: view.window)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: view.window)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: view.window)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        let keyboardHeight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height
        
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseIn.rawValue
        let animationCurve = UIViewAnimationOptions(rawValue: animationCurveRaw)
        
        guard let focusView = view.firstResponder()?.superview ?? view.firstResponder() else {
            return
        }
        
        let firstResponderOrigin = contentView.convert(focusView.bounds.origin, from: focusView)
        let firstResponderBottom = firstResponderOrigin.y + focusView.frame.height
        
        var finalViewHeight = scrollView.frame.height
        
        if scrollViewBottomConstraint.constant == 0 {
            finalViewHeight -= keyboardHeight ?? 0
        }
        
        var offset = firstResponderBottom - finalViewHeight/2 - focusView.frame.height/2
        
        if offset <= scrollView.contentInset.top {
            offset = scrollView.contentInset.top
        }
        
        scrollViewBottomConstraint.constant = -(keyboardHeight ?? 0)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve, animations: {
            self.view.layoutIfNeeded()
            self.scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
        }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25
        let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseOut.rawValue
        let animationCurve = UIViewAnimationOptions(rawValue: animationCurveRaw)
        
        scrollViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

