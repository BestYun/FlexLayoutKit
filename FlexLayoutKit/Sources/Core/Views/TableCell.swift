//
//  TableCell.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/9/21.
//

import Foundation
import UIKit

open class ListCell: UITableViewCell {
    ///默认为false,固定高度;为true，动态高度，配合rowHeight为UITableView.automaticDimension使用
    open var isDynamicHeight: Bool { false }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.flex
            .direction(.column)
            .addItems {
                if isDynamicHeight {
                    bodyView()
                }else {
                    //固定高度,拉伸高度
                    bodyView().flexBaseView.flex.expanded()
                }
            }
    }

    @available(*, unavailable)
    required  public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 定义view
    open func bodyView() -> FlexboxView {
        fatalError("bodyView has not been implemented")
    }

    open override  func layoutSubviews() {
        super.layoutSubviews()
        if isDynamicHeight {
            contentView.flex.applyLayout(mode: .adjustHeight)
        }else{
            contentView.flex.applyLayout(mode: .fitContainer)
        }
    }
    
    ///配置rowHeight为UITableView.automaticDimension,需要重写这个方法,计算高度
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        if isDynamicHeight {
            contentView.flex.applyLayout(mode: .adjustHeight)
            return contentView.frame.size
        }
        return super.sizeThatFits(size)
     }
}



/// 固定高度  UListViewCell
open class TableFixedCell: UITableViewCell {
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.flex
            .direction(.column)
            .addItems {
                ///拉伸高度
                bodyView().flexBaseView.flex.expanded()
            }
    }

    @available(*, unavailable)
    required  public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 定义view
    open func bodyView() -> FlexboxView {
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
    open func bodyView() -> FlexboxView {
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
    
// 或者重写这个方法
//    open override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        let newSize = contentView.flex.sizeThatFits(with: CGSize(width: targetSize.width, height: CGFloat.nan))
//        return newSize
//    }

}
