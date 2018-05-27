//
//  ZoomDismissAnimator.swift
//  swf-CustomTransition-demo
//
//  Created by S.Emoto on 2018/05/26.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit

class ZoomDismissAnimator: NSObject {

}

extension ZoomDismissAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        dismissTransition(transitionContext: transitionContext)
    }
    
    private func dismissTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        // 最初からcontainerViewがsubviewとして持っているfromVC.viewを削除
        fromVC.view.removeFromSuperview()
        
        // toView -> fromViewの順にaddSubview
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
        
        guard let sourceImageView = (fromVC as? DetailViewController)?.createImageView() else {
            return
        }
        guard let destinationImageView = (toVC as? ListViewController)?.createImageView() else {
            return
        }
        containerView.addSubview(sourceImageView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0.05, options: .curveEaseInOut,
                       animations: { () -> Void in
                        sourceImageView.frame = destinationImageView.frame
                        fromVC.view.alpha = 0.0
                        
        }) { (finished) -> Void in
            
            sourceImageView.isHidden = true
            
            (toVC as? ListViewController)?.selectedImageView?.isHidden = false
            transitionContext.completeTransition(true)
        }
    }
}
