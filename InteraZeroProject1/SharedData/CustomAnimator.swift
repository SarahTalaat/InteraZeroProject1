//
//  CustomAnimator.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 30/07/2024.
//

import Foundation
import UIKit

class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    enum AnimationType {
        case push
        case pop
    }
    
    let animationType: AnimationType
    
    init(animationType: AnimationType) {
        self.animationType = animationType
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5 
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: .from)!
        let toViewController = transitionContext.viewController(forKey: .to)!
        let duration = transitionDuration(using: transitionContext)
        
        switch animationType {
        case .push:
            containerView.addSubview(toViewController.view)
            toViewController.view.transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
            UIView.animate(withDuration: duration, animations: {
                toViewController.view.transform = .identity
                fromViewController.view.alpha = 0.5
            }, completion: { finished in
                fromViewController.view.alpha = 1.0
                transitionContext.completeTransition(finished)
            })
            
        case .pop:
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animate(withDuration: duration, animations: {
                toViewController.view.alpha = 1.0
                fromViewController.view.transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
            }, completion: { finished in
                fromViewController.view.transform = .identity
                transitionContext.completeTransition(finished)
            })
        }
    }
}
