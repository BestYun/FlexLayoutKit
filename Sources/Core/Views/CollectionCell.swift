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
