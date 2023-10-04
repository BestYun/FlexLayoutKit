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
        print(contentView.bounds)
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
        print(contentView.bounds)
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
    override open func sizeThatFits(_: CGSize) -> CGSize {
        // 重新这个方法UITableViewCell->sizeThatFits,然后再调用applyLayout方法计算高度
        // tableView.estimatedRowHeight = 60 需要预估计高度
        // 同时配置tableView.rowHeight = UITableView.automaticDimension或者代理重新
        contentView.flex.applyLayout(mode: .adjustHeight)
        return contentView.frame.size
    }

    //    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority _: UILayoutPriority, verticalFittingPriority _: UILayoutPriority) -> CGSize {
    //        let size = contentView.flex.sizeThatFits(with: CGSize(width: targetSize.width, height: CGFloat.nan))
    //
    //        return size
    //    }
}
