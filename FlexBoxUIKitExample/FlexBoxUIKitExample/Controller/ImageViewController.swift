//
//  ImageViewController.swift
//  FlexUIKitExample
//
//  Created by yun on 2023/10/7.
//

import UIKit
import FlexBoxUIKit

class ImageViewController: FlexBaseViewController {

    @UState var imgUrl = "https://upload-images.jianshu.io/upload_images/5809200-a99419bb94924e6d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"
    
    override func viewDidLoad() {
        
        view.flex.mainAxis(.center).crossAxis(.center)
        
        super.viewDidLoad()
        

    }
    
    override func bodyView() -> UIView {
            
        return VStackView {
            
            Text("SDWebImage")
            ImageView(url: $imgUrl).size(100).backgroundColor(.orange).margin(.vertical,10)
            
            Text("SDWebImage apply")
            ImageView().size(100).backgroundColor(.orange).margin(.vertical,10).apply { imageView in
                imageView.sd_setImage(with: URL(string: imgUrl))
            }
            
            Space(10)
            
//            Text("Kingfisher")
//            ImageView(url: $imgUrl).size(100).backgroundColor(.orange).margin(.vertical,10)
//            Text("Kingfisher apply")
            
//            ImageView().size(100).backgroundColor(.orange).margin(.vertical,10).apply { imageView in
//                imageView.kf.setImage(with: URL(string: imgUrl))
//            }
            
            Button("更换图片").onTap { [unowned self] in
                self.imgUrl = "https://upload-images.jianshu.io/upload_images/5809200-736bc3917fe92142.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"
            }
            .backgroundColor(.orange)
            .margin(.top,10)
            
        }
                
    }
    


    
}
