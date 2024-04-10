//
//  CollectionCell.swift
//  FlexUIKit
//
//  Created by yun on 2023/10/3.
//

import UIKit
//UGridViewCell
open class CollectionCell: UICollectionViewCell {
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
        contentView.flex.applyLayout()
    }

    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


open class CollectionDynamicCell: UICollectionViewCell {
    
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
        contentView.flex.applyLayout(mode: .adjustHeight)
    }

    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 重写这个方法,计算高度
    open override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        contentView.flex.applyLayout(mode: .adjustHeight)
        layoutAttributes.size = contentView.frame.size
//        print("size = \(contentView.frame.size)")
        return layoutAttributes
    }
    
}


open class HCollectionDynamicCell: UICollectionViewCell {
    
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
        contentView.flex.applyLayout(mode: .adjustWidth)
    }

    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 重写这个方法,计算高度
    open override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        contentView.flex.applyLayout(mode: .adjustWidth)
        layoutAttributes.size = contentView.frame.size
        print("size = \(contentView.frame.size)")
        return layoutAttributes
    }
}

