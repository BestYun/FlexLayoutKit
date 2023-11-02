//
//  ImageView+SDWebImage.swift
//  FlexBoxUIKit
//
//  Created by yun on 2023/11/2.
//

import Foundation
import Kingfisher

public extension ImageView {
    convenience init(url: String, placeholder: Placeholder? = nil,
                     options: KingfisherOptionsInfo? = nil,
                     completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil)
    {
        self.init()
        self.flex.markDirty()
        self.kf.setImage(with: URL(string: url), placeholder: placeholder, options: options)
    }

    convenience init(url state: UState<String>, placeholder: Placeholder? = nil,
                     options: KingfisherOptionsInfo? = nil,
                     completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil)
    {
        self.init(url: state.wrappedValue, placeholder: placeholder, options: options, completionHandler: completionHandler)
        state.listen { [weak self] _ in
            self?.flex.markDirty()
            self?.kf.setImage(with: URL(string: state.wrappedValue), placeholder: placeholder, options: options)
        }
    }
}
