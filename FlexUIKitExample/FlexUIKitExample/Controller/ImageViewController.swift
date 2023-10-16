//
//  ImageViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/7.
//

import UIKit

import Kingfisher

class ImageViewController: FlexBaseViewController {

    override func viewDidLoad() {
        
        view.flex.mainAxis(.center).crossAxis(.center)
        
        super.viewDidLoad()
        

    }
    
    override func bodyView() -> UIView {
        
        
        return ImageView().size(100).apply { imageView in
            let url = URL(string: "https://cdn.pixabay.com/photo/2023/09/29/10/21/nuts-8283540_1280.jpg")
//            imageView.kf.setImage(with: url)
//            imageView.kf.setImage(with: url,placeholder: Placeholder?)
        }.backgroundColor(.orange)
        
        
    }
    


    
}
