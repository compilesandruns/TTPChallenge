//
//  HomeScreenViewController.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

class HomeScreenViewController: BaseViewController {
    
    
    
}

extension HomeScreenViewController: HomeScreenViewable {
    func openMenu() {
        performSegueWithIdentifier("openMenu", sender: nil)
    }
    
    func closeMenu() {
        self.presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

//MARK: - Slide Menu
extension HomeScreenViewController {
    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .Right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactiveTransition: interactiveTransition) {
                self.openMenu()
        }
    }
}


extension HomeScreenViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? MenuViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactiveTransition = interactiveTransition
            
            if let delegate = presenter as? MenuDelegate {
                destinationViewController.menuDelegate = delegate
            }
        }
        
        if let navController = segue.destinationViewController as? UINavigationController {
            if let destinationViewController = navController.viewControllers.first as? WebScreenViewController {
                destinationViewController.intendedUrl = webScreenOptions.url
                destinationViewController.showControls = webScreenOptions.showControls
                destinationViewController.title = webScreenOptions.title
            }
        }
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
