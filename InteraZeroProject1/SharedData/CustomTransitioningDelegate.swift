//
//  CustomTransitioningDelegate.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 30/07/2024.
//

import Foundation

import UIKit

class CustomTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate , UINavigationControllerDelegate{
    enum TransitionType {
        case push
        case pop
    }
    
    let transitionType: TransitionType
    
    init(transitionType: TransitionType) {
        self.transitionType = transitionType
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return CustomAnimator(animationType: .push)
        case .pop:
            return CustomAnimator(animationType: .pop)
        default:
            return nil
        }
    }
}
