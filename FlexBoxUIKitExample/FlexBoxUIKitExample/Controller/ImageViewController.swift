//
//  ImageViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/7.
//

import UIKit
//import SDWebImage
import FlexBoxUIKit



//import Kingfisher

class ImageViewController: FlexBaseViewController {

    override func viewDidLoad() {
        
        view.flex.mainAxis(.center).crossAxis(.center)
        
        super.viewDidLoad()
        

    }
    
    override func bodyView() -> UIView {
        
        
        
        let url = "https://cdn.pixabay.com/photo/2023/09/29/10/21/nuts-8283540_1280.jpg"
        
        return VStackView {
            Text("SDWebImage")
            ImageView(url: url).size(100).backgroundColor(.orange).margin(.vertical,10)
            Text("SDWebImage apply")
            ImageView().size(100).backgroundColor(.orange).margin(.vertical,10).apply { imageView in
                imageView.sd_setImage(with: URL(string: url))
            }
        }
        
        
//        return ImageView().size(100).apply { imageView in
//            let url = URL(string: "https://cdn.pixabay.com/photo/2023/09/29/10/21/nuts-8283540_1280.jpg")
//            imageView.kf.setImage(with: url)
//            imageView.kf.setImage(with: url,placeholder: Placeholder?)
//        }.backgroundColor(.orange)
        
    }
    


    
}
