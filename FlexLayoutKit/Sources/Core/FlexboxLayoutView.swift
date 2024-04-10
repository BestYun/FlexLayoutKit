//
//  FlexView.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/7/27.
//

import Foundation
import UIKit

// yoga Container
public class FlexContainer: UIView, UViewChain, FlexboxLayout {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        yoga.enabled(true)
    }

    public init(direction: FlexDirection = .column,
                mainAxis: MainAxisAlignment = .start,
                crossAxis: CrossAxisAlignment = .stretch,
                @FlexboxViewBuilder subviews: () -> [FlexboxView])
    {
        super.init(frame: .zero)
        yoga.enabled(true)
            .direction(direction)
            .mainAxis(mainAxis)
            .crossAxis(crossAxis)

        let subviews = subviews()
        subviews.forEach { subview in
            let view = subview.flexBaseView
            if let spacer = view as? Spacer {
                if direction == .column || direction == .columnReverse {
                    spacer.yoga.height(spacer.spacing)
                } else {
                    spacer.yoga.width(spacer.spacing)
                }
            }
            addSubview(view)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
public class Row: FlexContainer {
    public init(mainAxis: MainAxisAlignment = .start,
                crossAxis: CrossAxisAlignment = .stretch,
                spacing: CGFloat = 0,
                @FlexboxViewBuilder subviews: () -> [FlexboxView])
    {
        super.init(direction: .row, mainAxis: mainAxis, crossAxis: crossAxis, subviews: subviews)
        self.yoga.columnGap = spacing
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func spacing(_ spacing: CGFloat) -> Self{
        self.yoga.columnGap = spacing
        return self
    }
}

public class Column: FlexContainer {
    public init(mainAxis: MainAxisAlignment = .start,
                crossAxis: CrossAxisAlignment = .stretch,
                spacing: CGFloat = 0,
                @FlexboxViewBuilder subviews: () -> [FlexboxView])
    {
        super.init(direction: .column, mainAxis: mainAxis, crossAxis: crossAxis, subviews: subviews)
        self.yoga.rowGap = spacing
        
    }

    public func spacing(_ spacing: CGFloat) -> Self{
        self.yoga.rowGap = spacing
        return self
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
///Horizontal Wrap
public class HWrap: FlexContainer {
    /// MainAxisAlignment: 主轴方向
    /// alignContent: 次轴方向->针对多行整体布局 对应:alignContent
    /// crossAxis:次轴方法->每一行中的item布局,每项高度或者宽度不一样时就有效果
    /// spacing: main axis
    /// spacingVertical: 垂直方向
    /// mainAxisAlignment
    public init(
                mainAxis: MainAxisAlignment = .start,
                alignContent: AlignContent = .start,
                crossAxis: WrapCrossAlignment = .start,
                spacing: CGFloat? = nil,
                spacingVertical: CGFloat? = nil,
                @FlexboxViewBuilder subviews: () -> [FlexboxView])
    {
        super.init(direction: .row, mainAxis: mainAxis, crossAxis: crossAxis.crossAxis, subviews: subviews)
        yoga.flexWrap = .wrap

        yoga.alignContent(alignContent)
        
        if let spacing = spacing {
            self.spacing(spacing)
        }
        
        if let spacingVertical = spacingVertical {
            self.spacingVertical(spacingVertical)
        }
    }
    ///main axis space
    @discardableResult
    public func spacing(_ spacing: CGFloat) -> Self{
        self.yoga.columnGap = spacing
        return self
    }
    
    @discardableResult
    public func spacingVertical(_ spacing: CGFloat) -> Self{
        self.yoga.rowGap = spacing
        return self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///Vertical Wrap
public class VWrap: FlexContainer {
    /// MainAxisAlignment: 主轴方向
    /// alignContent: 次轴方向->针对多行整体布局 对应:alignContent
    /// crossAxis:次轴方法->每一行中的item布局,每项高度或者宽度不一样时就有效果
    /// spacing: main axis
    /// spacingHorizontal: 水平方向
    /// mainAxisAlignment
    public init(
                mainAxis: MainAxisAlignment = .start,
                alignContent: AlignContent = .start,
                crossAxis: WrapCrossAlignment = .start,
                spacing: CGFloat? = nil,
                spacingHorizontal: CGFloat? = nil,
                @FlexboxViewBuilder subviews: () -> [FlexboxView])
    {
        super.init(direction: .column, mainAxis: mainAxis, crossAxis: crossAxis.crossAxis, subviews: subviews)
        yoga.flexWrap = .wrap

        yoga.alignContent(alignContent)
        
        if let spacing = spacing {
            self.spacing(spacing)
        }
        
        if let spacingHorizontal = spacingHorizontal {
            self.spacingHorizontal(spacingHorizontal)
        }
    }
    
    ///main axis space
    @discardableResult
    public func spacing(_ spacing: CGFloat) -> Self{
        self.yoga.rowGap = spacing
        return self
    }
    
    @discardableResult
    public func spacingHorizontal(_ spacing: CGFloat) -> Self{
        self.yoga.columnGap = spacing
        return self
    }    
    

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/**
 * Stack必须设置宽或高
 */
public class Stack: FlexContainer {
    override public init(direction: FlexDirection = .column,
                         mainAxis: MainAxisAlignment = .start,
                         crossAxis: CrossAxisAlignment = .stretch,
                         @FlexboxViewBuilder subviews: () -> [FlexboxView])
    {
        let subviews = subviews()
        subviews.forEach { itemView in
            let view = itemView.flexBaseView
            view.yoga.position(.absolute)
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

// MARK: - 类似SwiftUI
public typealias HStackView = Row
public typealias VStackView = Column
public typealias ZStackView = Stack
