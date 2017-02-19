//
//  HomeScreenViewController.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import PKHUD
import SafariServices

class HomeScreenViewController: BaseViewController {
    var presenter: HomeScreenPresenting!
    
    let interactiveTransition = SlideMenuInteractiveTransition()
    var webScreenOptions: (url: String, showControls: Bool, title: String)!

    @IBOutlet weak var menuButtonItem: UIBarButtonItem!
    
    @IBOutlet var navBarEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Injector.currentInjector.homeScreenPresenter(view: self)
        
        navigationController?.navigationBar.addGestureRecognizer(navBarEdgePanGestureRecognizer)
        
        presenter.viewDidLoad()
    }
    deinit {
        self.navigationController?.navigationBar.removeGestureRecognizer(navBarEdgePanGestureRecognizer)
    }
}

extension HomeScreenViewController: HomeScreenViewable {
    func openMenu() {
        performSegue(withIdentifier: "OpenMenu", sender: nil)
    }
    
    func closeMenu() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func showWebView(url: String) {
        guard var _ = NSURL(string: url) else {
            return
        }
        let safariViewController = SFSafariViewController(url: URL(string: url)!)
        present(safariViewController, animated: true, completion: nil)

    }
    
    func showLoginFlow() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showSignIn", sender: self)
        }
    }
    
    func showQuizFlow() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showQuizFlow", sender: self)
        }
    }
    
    func showSuggestedEventsFlow() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showSuggestedEventsFlow", sender: self)
        }
    }
    
    func showSavedEventsFlow() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showSavedEventsFlow", sender: self)
        }
    }
    
    func showChatFlow() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showChatFlow", sender: self)
        }
    }
    
    func showLoader() {
        HUD.show(.progress)
    }
    
    func hideLoader() {
        HUD.hide()
    }
}

extension HomeScreenViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MenuViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactiveTransition = interactiveTransition
            
            if let delegate = presenter as? MenuDelegate {
                destinationViewController.menuDelegate = delegate
            }
        }
    }
}

//MARK: - Slide Menu
extension HomeScreenViewController {
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            gestureState: sender.state,
            progress: progress,
            interactiveTransition: interactiveTransition) {
                self.openMenu()
        }
    }
}

//MARK: Slide Transitions
extension HomeScreenViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}
