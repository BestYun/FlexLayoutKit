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

    public init(direction: FlexDirection = .column, mainAxis: MainAxisAlignment = .start, crossAxis: CrossAxisAlignment = .stretch, @FlexViewBuilder subviews: () -> [UIView]) {
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
    public init(mainAxis: MainAxisAlignment = .start, crossAxis: CrossAxisAlignment = .stretch, @FlexViewBuilder subviews: () -> [UIView]) {
        super.init(direction: .row, mainAxis: mainAxis, crossAxis: crossAxis, subviews: subviews)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class Column: FlexContainerView {
    public init(mainAxis: MainAxisAlignment = .start, crossAxis: CrossAxisAlignment = .stretch, @FlexViewBuilder subviews: () -> [UIView]) {
        super.init(direction: .column, mainAxis: mainAxis, crossAxis: crossAxis, subviews: subviews)
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
    public init(direction: FlexDirection = .row, mainAxis: MainAxisAlignment = .start, runAlignment: AlignContent = .start, crossAxis: WrapCrossAlignment = .start, @FlexViewBuilder subviews: () -> [UIView]) {
        super.init(direction: direction, mainAxis: mainAxis, crossAxis: crossAxis.crossAxis, subviews: subviews)
        flex.wrap(.wrap).alignContent(runAlignment)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 类似SwiftUI

public typealias HStackView = Row
public typealias VStackView = Column

public class ZStackView: FlexContainerView {
    override public init(direction: FlexDirection = .column, mainAxis: MainAxisAlignment = .start, crossAxis: CrossAxisAlignment = .stretch, @FlexViewBuilder subviews: () -> [UIView]) {
        let subviews = subviews()
        subviews.forEach { itemView in
            itemView.yoga.position(.absolute)
        }

        let block = {
            subviews
        }
        super.init(direction: direction, mainAxis: mainAxis, crossAxis: crossAxis, subviews: block)

        yoga.position(.relative)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlexContainerView: FlexViewChain {}
extension FlexContainerView: FlexLayout {}

public class Positioned {
    var left: CGFloat?
    var top: CGFloat?
    var right: CGFloat?
    var bottom: CGFloat?
    var height: CGFloat?
    var width: CGFloat?
    let child: UIView

    init(left: CGFloat? = nil, top: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, height: CGFloat? = nil, width: CGFloat? = nil, child: UIView) {
        self.left = left
        self.top = top
        self.right = right
        self.bottom = bottom
        self.height = height
        self.width = width
        self.child = child

        if let left = left {
            child.flex.left(left)
        }

        if let top = top {
            child.flex.top(top)
        }

        if let right = right {
            child.flex.right(right)
        }

        if let bottom = bottom {
            child.flex.bottom(bottom)
        }

        if let height = height {
            child.flex.size(height: height)
        }
        if let width = width {
            child.flex.size(width: width)
        }
    }
}
