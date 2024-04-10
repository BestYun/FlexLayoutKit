//
//  ImageView.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/9/11.
//


import UIKit

public class ImageView: UIImageView, FlexboxLayout, UViewChain  {
    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        enabled(true)
        
    }

    public convenience init(_ image: UIImage?) {
        self.init(frame: .zero)
        self.image = image
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension ImageView {
    @discardableResult func image(_ image: UIImage?) -> Self {
        self.image = image
        markDirty()
        return self
    }

    @discardableResult func highlightedImage(_ highlightedImage: UIImage?) -> Self {
        
        self.highlightedImage = highlightedImage
        markDirty()
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult func preferredSymbolConfiguration(_ preferredSymbolConfiguration: UIImage.SymbolConfiguration?) -> Self {
        self.preferredSymbolConfiguration = preferredSymbolConfiguration
        return self
    }

    @discardableResult func isHighlighted(_ isHighlighted: Bool) -> Self {
        self.isHighlighted = isHighlighted
        return self
    }

    @discardableResult func animationImages(_ animationImages: [UIImage]?) -> Self {
        self.animationImages = animationImages
        markDirty()
        return self
    }

    @discardableResult func highlightedAnimationImages(_ highlightedAnimationImages: [UIImage]?) -> Self {
        self.highlightedAnimationImages = highlightedAnimationImages
        markDirty()
        return self
    }

    @discardableResult func animationDuration(_ animationDuration: TimeInterval) -> Self {
        self.animationDuration = animationDuration

        return self
    }

    @discardableResult func animationRepeatCount(_ animationRepeatCount: Int) -> Self {
        self.animationRepeatCount = animationRepeatCount
        return self
    }

    @discardableResult func tintColor(_ tintColor: UIColor!) -> Self {
        self.tintColor = tintColor
        return self
    }
}
