//
//  TableCell.swift
//  FlexKit
//
//  Created by yun on 2023/9/21.
//

import Foundation
import UIKit

/// 固定高度
open class TableCell: UITableViewCell {
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        ///bodyView.bounds.size = contentView.bounds.size
        contentView.flex
            .direction(.row)
            .addItems {
                ///拉伸宽度
                bodyView().flex.expanded().view
            }
    }

    @available(*, unavailable)
    required  public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 定义view
    open func bodyView() -> UIView {
        fatalError("bodyView has not been implemented")
    }

    open override  func layoutSubviews() {
        super.layoutSubviews()
        contentView.flex.applyLayout()
    }
}

/*
 * 动态计算高度
 *
 */
open class TableDynamicCell: UITableViewCell {
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.flex
            .direction(.column)
            .addItems {
                bodyView()
            }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 定义view
    open func bodyView() -> UIView {
        fatalError("bodyView has not been implemented")
    }

    
    open override func layoutSubviews() {
        super.layoutSubviews()
        contentView.flex.applyLayout(mode: .adjustHeight)
    }
    /// 重写这个方法,计算高度
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.flex.applyLayout(mode: .adjustHeight)
        return contentView.frame.size
    }

}
