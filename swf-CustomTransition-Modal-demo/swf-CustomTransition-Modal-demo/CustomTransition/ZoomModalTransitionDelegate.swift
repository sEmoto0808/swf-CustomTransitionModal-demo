//
//  ZoomModalTransitionDelegate.swift
//  swf-CustomTransition-demo
//
//  Created by S.Emoto on 2018/05/26.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit

class ZoomModalTransitionDelegate: NSObject {
}

extension ZoomModalTransitionDelegate: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(forPresented presented: UIViewController,
                                                   presenting: UIViewController,
                                                   source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZoomPresentedAnimator()
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ZoomDismissAnimator()
    }
}
