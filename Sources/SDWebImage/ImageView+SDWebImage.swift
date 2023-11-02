//
//  ImageView+SDWebImage.swift
//  FlexBoxUIKit
//
//  Created by yun on 2023/11/2.
//

import Foundation
import SDWebImage

public typealias SDWebImageCompleted = (UIImage?, Error?, SDImageCacheType, URL?) -> Void
public typealias SDWebImageProgress = (Int,Int,URL?) -> Void

extension ImageView {
        
    public convenience init(url: String, placeholderImage: UIImage? = nil, options:SDWebImageOptions = .waitStoreCache,context: [SDWebImageContextOption : Any]? = nil, progress: SDWebImageProgress? = nil, completed: SDWebImageCompleted? = nil ){
        self.init()
        self.flex.markDirty()
        self.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage, options: options, context: context,progress: progress,completed: completed)
    }
}
