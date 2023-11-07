//
//  FlexView.swift
//  FlexKit
//
//  Created by yun on 2023/7/27.
//

import Foundation
import UIKit

// Flex Container
public class FlexContainerView: UIView {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        flex.enabled(true)
    }

    public init(direction: FlexDirection = .column,
                mainAxis: MainAxisAlignment = .start,
                crossAxis: CrossAxisAlignment = .stretch,
                @FlexViewBuilder subviews: () -> [UIView])
    {
        super.init(frame: .zero)
        flex.enabled(true)
            .direction(direction)
            .mainAxis(mainAxis)
            .crossAxis(crossAxis)

        let subviews = subviews()
        subviews.forEach { subview in

            subview.flex.enabled(true)

            if let spacer = subview as? Space {
                if direction == .column || direction == .columnReverse {
                    spacer.flex.height(spacer.space)
                } else {
                    spacer.flex.width(spacer.space)
                }
            }
            addSubview(subview)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class Row: FlexContainerView {
    public init(mainAxis: MainAxisAlignment = .start,
                crossAxis: CrossAxisAlignment = .stretch,
                space: CGFloat = 0,
                @FlexViewBuilder subviews: () -> [UIView])
    {
        super.init(direction: .row, mainAxis: mainAxis, crossAxis: crossAxis, subviews: subviews)
        self.flex.columnGap(space)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class Column: FlexContainerView {
    public init(mainAxis: MainAxisAlignment = .start,
                crossAxis: CrossAxisAlignment = .stretch,
                space: CGFloat = 0,
                @FlexViewBuilder subviews: () -> [UIView])
    {
        super.init(direction: .column, mainAxis: mainAxis, crossAxis: crossAxis, subviews: subviews)
        self.flex.rowGap(space)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class Wrap: FlexContainerView {
    /// MainAxisAlignment: 主轴方向
    /// runAlignment: 次轴方向->针对行整体布局 对应:alignContent
    /// crossAxis:次轴方法->每一行中的item布局,每项高度或者宽度不一样时就有效果
    public init(direction: FlexDirection = .row,
                mainAxis: MainAxisAlignment = .start,
                runAlignment: AlignContent = .start,
                crossAxis: WrapCrossAlignment = .start,
                rowGap: CGFloat = 0,
                columnGap: CGFloat = 0,
                gap: CGFloat = 0,
                @FlexViewBuilder subviews: () -> [UIView])
    {
        super.init(direction: direction, mainAxis: mainAxis, crossAxis: crossAxis.crossAxis, subviews: subviews)
        flex.wrap(.wrap).alignContent(runAlignment)
        if gap == 0 {
            flex.rowGap(rowGap).columnGap(columnGap)
        } else {
            flex.gap(gap)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/**
 * 必须设置宽高
 */
public class Stack: FlexContainerView {
    override public init(direction: FlexDirection = .column,
                         mainAxis: MainAxisAlignment = .start,
                         crossAxis: CrossAxisAlignment = .stretch,
                         @FlexViewBuilder subviews: () -> [UIView])
    {
        let subviews = subviews()
        subviews.forEach { itemView in
            itemView.flex.position(.absolute)
        }

        let block = {
            subviews
        }
        super.init(direction: direction, mainAxis: mainAxis, crossAxis: crossAxis, subviews: block)

        flex.position(.relative)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 类似SwiftUI和Flutter

public typealias HStackView = Row
public typealias VStackView = Column
public typealias ZStackView = Stack

extension FlexContainerView: FlexViewChain {}
extension FlexContainerView: FlexLayout {}
