//
//  DismissMenuAnimator.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//


import UIKit

class DismissMenuAnimator : NSObject {
}

extension DismissMenuAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        transitionContext.containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                toVC.view.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
        },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    
                    toVC.view.isUserInteractionEnabled = true
                    toVC.view.layer.shadowOpacity = 0.0
                    
                    if let window = UIApplication.shared.keyWindow {
                        if let vc = window.rootViewController {
                            window.addSubview(vc.view)
                        }
                    }
                }
                transitionContext.completeTransition(didTransitionComplete)
        }
        )
    }
}
