//
//  MenuHelper.swift
//  TTPChallenge
//
//  Created by Stephanie Guevara on 2/12/17.
//  Copyright © 2017 TeamMDC. All rights reserved.
//

import Foundation
import UIKit

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

struct MenuHelper {
    
    static let menuWidth:CGFloat = 272.0
    
    static let percentThreshold:CGFloat = 0.3
    
    static func calculateProgress(translationInView:CGPoint, viewBounds:CGRect, direction:Direction) -> CGFloat {
        let pointOnAxis:CGFloat
        let axisLength:CGFloat
        switch direction {
        case .Up, .Down:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
        case .Left, .Right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        let movementOnAxis = pointOnAxis / axisLength
        let positiveMovementOnAxis:Float
        let positiveMovementOnAxisPercent:Float
        switch direction {
        case .Right, .Down: // positive
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)
        case .Up, .Left: // negative
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }
    
    static func mapGestureStateToInteractor(gestureState:UIGestureRecognizerState, progress:CGFloat, interactiveTransition: SlideMenuInteractiveTransition?, triggerSegue: () -> ()){
        guard let interactiveTransition = interactiveTransition else { return }
        switch gestureState {
        case .began:
            interactiveTransition.hasStarted = true
            triggerSegue()
        case .changed:
            interactiveTransition.shouldFinish = progress > percentThreshold
            interactiveTransition.update(progress)
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish
                ? interactiveTransition.finish()
                : interactiveTransition.cancel()
        default:
            break
        }
    }
    
}
