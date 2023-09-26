//
//  TableCell.swift
//  FlexKit
//
//  Created by yun on 2023/9/21.
//

import Foundation
import UIKit

/// 动态高度
public class TableCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.flex.direction(.column).addItems {
            bodyView()
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 定义view
    public func bodyView() -> UIView {
        fatalError("bodyView has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        contentView.flex.applyLayout(mode: .adjustHeight)
    }
}

/*
 * 动态计算高度
 *
 */
public class TableDynamicCell: TableCell {
    /// 重写这个方法,计算高度
    override public func sizeThatFits(_: CGSize) -> CGSize {
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
