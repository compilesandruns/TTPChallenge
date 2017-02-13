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
    @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!
    
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
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK NotificationCenter
extension CreateUserScreenViewController {
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
