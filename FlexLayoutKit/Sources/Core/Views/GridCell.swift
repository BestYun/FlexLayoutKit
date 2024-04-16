//
//  CollectionCell.swift
//  FlexUIKit
//
//  Created by yun on 2023/10/3.
//

import UIKit
//UGridViewCell

open class GridCell: UICollectionViewCell {
    
    ///默认为false,固定高度;为true，动态高度
    open var isDynamicHeight: Bool { false }
    ///
    open var scrollDirection: UICollectionView.ScrollDirection { .vertical }// default is UICollectionViewScrollDirectionVertical

    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView
            .flex
            .direction(.column)
            .crossAxis(.stretch)
            .addItems {
                bodyView()
            }
    }
    
    
    // 定义view
    open func bodyView() -> FlexboxView {
        fatalError("bodyView has not been implemented")
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        if isDynamicHeight {
            contentView.flex.applyLayout(mode: scrollDirection == .vertical ? .adjustHeight : .adjustWidth)
        }else{
            contentView.flex.applyLayout(mode: .fitContainer)
        }

    }

    
    /// 重写这个方法,计算高度
    open override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        if !isDynamicHeight {
            return super.preferredLayoutAttributesFitting(layoutAttributes)
        }
        
        contentView.flex.applyLayout(mode: scrollDirection == .vertical ? .adjustHeight : .adjustWidth)
        layoutAttributes.size = contentView.frame.size
        return layoutAttributes
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
