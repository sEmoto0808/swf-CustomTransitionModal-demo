//
//  DetailViewController.swift
//  swf-CustomTransition-Modal-demo
//
//  Created by S.Emoto on 2018/05/26.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var image: UIImage?
    var zoomModalTransitionDelegate: ZoomModalTransitionDelegate?
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        zoomModalTransitionDelegate = ZoomModalTransitionDelegate()
        self.transitioningDelegate = zoomModalTransitionDelegate
    }
}

extension DetailViewController {
    
    func createImageView() -> UIImageView? {
        guard let detailImageView = self.detailImageView else {
            return nil
        }
        let imageView = UIImageView(image: self.image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = detailImageView.frame
        return imageView
    }
    
    @IBAction func didTapDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
