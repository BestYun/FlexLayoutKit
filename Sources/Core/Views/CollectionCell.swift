//
//  CollectionCell.swift
//  FlexUIKit
//
//  Created by yun on 2023/10/3.
//

import UIKit

open class CollectionCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.flex.direction(.column).addItems {
            bodyView()
        }
    }
    
    
    // 定义view
    open func bodyView() -> UIView {
        fatalError("bodyView has not been implemented")
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        contentView.flex.applyLayout()
    }

    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


open class CollectionDynamicCell: CollectionCell {
    
//    open override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//
//        layoutAttributes.size = self.intrinsicContentSize
//
//        return layoutAttributes
//    }
//
//    open override var intrinsicContentSize: CGSize {
//        return self.contentView.flex.intrinsicSize
//    }
    
    
    open override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority _: UILayoutPriority, verticalFittingPriority _: UILayoutPriority) -> CGSize {
            let size = contentView.flex.sizeThatFits(with: CGSize(width: targetSize.width, height: CGFloat.nan))
        print(size)
            return size
        }
    
}

