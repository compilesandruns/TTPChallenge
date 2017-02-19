//
//  PresentMenuAnimator.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/13/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import UIKit

class PresentMenuAnimator : NSObject {
}

extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
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
        transitionContext.containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        transitionContext.containerView.insertSubview(fromVC.view, aboveSubview: toVC.view)
        
        fromVC.view.isUserInteractionEnabled = false
        fromVC.view.layer.shadowOpacity = 0.7
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                fromVC.view.center.x += MenuHelper.menuWidth
        },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if !didTransitionComplete {
                    fromVC.view.layer.shadowOpacity = 0.0
                    fromVC.view.isUserInteractionEnabled = true
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
