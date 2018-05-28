//
//  ZoomPresentedAnimator.swift
//  swf-CustomTransition-demo
//
//  Created by S.Emoto on 2018/05/26.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit

class ZoomPresentedAnimator: NSObject {}

extension ZoomPresentedAnimator: UIViewControllerAnimatedTransitioning {
    
    //MARK: - アニメーションの時間
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    //MARK: - アニメーションの実装
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        presentedTransition(transitionContext: transitionContext)
    }
    
    private func presentedTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 遷移元のViewController
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        
        // 遷移先のViewController
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        // アニメーションの土台となるビュー
        let containerView = transitionContext.containerView
        
        // 遷移先のviewをaddSubviewする（fromVC.viewは最初からcontainerViewがsubviewとして持っている）
        containerView.addSubview(toVC.view)
        
        // addSubviewでレイアウトが崩れるため再レイアウトする
        toVC.view.layoutIfNeeded()
        
        // アニメーション用のimageViewを新しく作成する
        //TODO: - 画面遷移をカスタムするViewControllerでcreateImageView()を実装する
        guard let sourceImageView = (fromVC as? ListViewController)?.createImageView() else {
            return
        }
        guard let destinationImageView = (toVC as? DetailViewController)?.createImageView() else {
            return
        }
        
        // 遷移元のimageViewをaddSubviewする
        containerView.addSubview(sourceImageView)
        
        toVC.view.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0.05,
                       options: .curveEaseInOut,
                       animations: { () -> Void in
                        
                        // アニメーション開始
                        // 遷移先のimageViewのframeとcontentModeを遷移元のimageViewに代入
                        sourceImageView.frame = destinationImageView.frame
                        sourceImageView.contentMode = destinationImageView.contentMode
                        // cellのimageViewを非表示にする
                        (fromVC as? ListViewController)?.selectedImageView?.isHidden = true
                        
                        toVC.view.alpha = 1.0
                        
        }) { (finished) -> Void in
            // アニメーション終了
            transitionContext.completeTransition(true)
        }
    }
}
