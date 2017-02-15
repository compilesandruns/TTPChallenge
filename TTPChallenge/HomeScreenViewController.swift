//
//  HomeScreenViewController.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

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
}

extension HomeScreenViewController: HomeScreenViewable {
    func openMenu() {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    func closeMenu() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func showWebView(url: String) {
        webScreenOptions = (url, false, "")
        self.performSegue(withIdentifier: "showWebView", sender: self)
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


extension HomeScreenViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MenuViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactiveTransition = interactiveTransition
            
            if let delegate = presenter as? MenuDelegate {
                destinationViewController.menuDelegate = delegate
            }
        }
        
//        if let navController = segue.destination as? UINavigationController {
//            if let destinationViewController = navController.viewControllers.first as? WebScreenViewController {
//                destinationViewController.intendedUrl = webScreenOptions.url
//                destinationViewController.showControls = webScreenOptions.showControls
//                destinationViewController.title = webScreenOptions.title
//            }
//        }
    }
}

//MARK: Slide Transitions
extension HomeScreenViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}
