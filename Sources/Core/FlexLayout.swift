//
//  FlexLayout.swift
//
//  Created by yun on 2023/8/2.
//

import FlexBoxYogaKit
import Foundation

public protocol FlexLayout {
    func isIncludedInLayout(_ isIncludedInLayout: Bool) -> Self
    func enabled(_ isEnabled: Bool) -> Self

    func display(_ display: Bool) -> Self
    func display(_ display: UState<Bool>) -> Self

    func padding(_ padding: CGFloat) -> Self
    func padding(_ edge: FEdge, _ length: CGFloat) -> Self
    func padding(_ edge: [FEdge], _ length: CGFloat) -> Self
    func padding(_ insets: UIEdgeInsets) -> Self
    @available(iOS 11.0, *)
    func padding(_ directionalInsets: NSDirectionalEdgeInsets) -> Self

    func margin(_ margin: CGFloat) -> Self
    func margin(_ edge: FEdge, _ length: CGFloat) -> Self
    func margin(_ edge: [FEdge], _ length: CGFloat) -> Self
    func margin(_ insets: UIEdgeInsets) -> Self
    @available(iOS 11.0, *)
    func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> Self
    func margin(_ percent: FlexPercent) -> Self
    func margin(_ edge: FEdge, _ percent: FlexPercent) -> Self
    func margin(_ edge: [FEdge], _ percent: FlexPercent) -> Self

    func borderWidth(_ all: CGFloat) -> Self
    func borderWidth(_ edge: FEdge, _ length: CGFloat) -> Self

    /// gap 设置行和列之间的间隙（gutter）大小。它是 rowGap 和 columnGap 的简写形式。
    func gap(_ gap: CGFloat) -> Self
    /// rowGap 设置元素行之间的间隙（gutter）大小。
    func rowGap(_ gap: CGFloat) -> Self
    /// columnGap 设置元素列之间的间隙（gutter）大小。
    func columnGap(_ gap: CGFloat) -> Self

    // 结合position或者ZStack
    func left(_ left: CGFloat) -> Self
    func top(_ top: CGFloat) -> Self
    func right(_ right: CGFloat) -> Self
    func bottom(_ bottom: CGFloat) -> Self
    func leading(_ start: CGFloat) -> Self
    func trailing(_ end: CGFloat) -> Self

    func width(_ width: CGFloat?) -> Self
    func height(_ height: CGFloat?) -> Self
    func width(_ percent: FlexPercent) -> Self
    func height(_ percent: FlexPercent) -> Self
    
    func size(width: CGFloat?, height: CGFloat?) -> Self
    func size(width: FlexPercent?, height: FlexPercent?) -> Self
    func size(_ size: CGFloat) -> Self
    func size(_ percent: FlexPercent) -> Self
    func size(_ size: CGSize) -> Self
    func size(minWidth: CGFloat?, maxWidth: CGFloat?, minHeight: CGFloat?, maxHeight: CGFloat?) -> Self

    /// Yoga specific properties, not compatible with flexbox specification
    func aspectRatio(_ aspectRatio: CGFloat) -> Self

    func direction(_ direction: FlexDirection) -> Self
    /// 主轴布局 -> justifyContent
    func mainAxis(_ mainAxis: MainAxisAlignment) -> Self
    /// 次轴布局: 针对单行布局 -> alignItems
    func crossAxis(_ crossAxis: CrossAxisAlignment) -> Self

    /// 次轴布局: 针对多行布局 -> alignContent
    func alignContent(_ alignContent: AlignContent) -> Self

    /// 定位
    func position(_ position: PositionType) -> Self

    func wrap(_ wrap: WrapType) -> Self

    // func direction(_ direction: YGDirection) -> Self
    func inherit() -> Self
    func ltr() -> Self
    func rtl() -> Self

    /// 设置cross轴的自身对齐方式
    func alignSelf(_ alignSelf: AlignSelf) -> Self
    /// 主轴方向拉伸
    func flex(_ flex: CGFloat) -> Self
    func grow(_ grow: CGFloat) -> Self
    func shrink(_ shrink: CGFloat) -> Self
    func basis(_ basis: CGFloat) -> Self
    func expanded() -> Self

    // 属性
    var yoga: YGLayout { get }

    var direction: FlexDirection { get }

    func applyLayout(preservingOrigin: Bool)
    func applyLayout(mode: LayoutMode, preservingOrigin: Bool)

    var intrinsicSize: CGSize { get }
    func sizeThatFits(with: CGSize) -> CGSize

    var numberOfChildren: UInt {
        get
    }

    var isLeaf: Bool {
        get
    }

    var isDirty: Bool {
        get
    }

    func markDirty()
}

public extension FlexLayout {
    @discardableResult func isIncludedInLayout(_ isIncludedInLayout: Bool) -> Self {
        yoga.isIncludedInLayout = isIncludedInLayout
        return self
    }

    @discardableResult func enabled(_ isEnabled: Bool) -> Self {
        yoga.isEnabled = isEnabled
        return self
    }

    @discardableResult func display(_ display: Bool) -> Self {
        yoga.display = display ? .flex : .none
        return self
    }

    @discardableResult func display(_ display: UState<Bool>) -> Self {
        display.listen {
            yoga.display = display.wrappedValue ? .flex : .none
        }
        return self
    }

    @discardableResult func padding(_ padding: CGFloat) -> Self {
        yoga.padding = YGValue(padding)
        return self
    }

    @discardableResult func padding(_ edge: FEdge = .all, _ length: CGFloat) -> Self {
        switch edge {
        case .all: yoga.padding = YGValue(length)
        case .left: yoga.paddingLeft = YGValue(length)
        case .leading: yoga.paddingStart = YGValue(length)
        case .right: yoga.paddingRight = YGValue(length)
        case .trailing: yoga.paddingEnd = YGValue(length)
        case .bottom: yoga.paddingBottom = YGValue(length)
        case .top: yoga.paddingTop = YGValue(length)
        case .horizontal: yoga.paddingHorizontal = YGValue(length)
        case .vertical: yoga.paddingVertical = YGValue(length)
        }
        return self
    }

    @discardableResult func padding(_ edge: [FEdge], _ length: CGFloat) -> Self {
        edge.forEach {
            _ = padding($0, length)
        }
        return self
    }

    @discardableResult func padding(_ insets: UIEdgeInsets) -> Self {
        _ = padding(.top, insets.top)
        _ = padding(.bottom, insets.bottom)
        _ = padding(.left, insets.left)
        _ = padding(.right, insets.right)

        return self
    }

    @available(iOS 11.0, *)
    @discardableResult func padding(_ directionalInsets: NSDirectionalEdgeInsets) -> Self {
        _ = padding(.top, directionalInsets.top)
        _ = padding(.bottom, directionalInsets.bottom)
        _ = padding(.trailing, directionalInsets.trailing)
        _ = padding(.leading, directionalInsets.leading)

        return self
    }

    @discardableResult func margin(_ margin: CGFloat) -> Self {
        yoga.margin = YGValue(margin)
        return self
    }

    @discardableResult func margin(_ percent: FlexPercent) -> Self {
        yoga.margin = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }

    @discardableResult func margin(_ edge: FEdge = .all, _ percent: FlexPercent) -> Self {
        let value = YGValue(value:Float(percent.value),unit: .percent)
        switch edge {
        case .all: yoga.margin = value
        case .left: yoga.marginLeft = value
        case .leading: yoga.marginStart = value
        case .right: yoga.marginRight = value
        case .trailing: yoga.marginEnd = value
        case .bottom: yoga.marginBottom = value
        case .top: yoga.marginTop = value
        case .horizontal: yoga.marginHorizontal = value
        case .vertical: yoga.marginVertical = value
        }
        return self

    }
        
    @discardableResult func margin(_ edge: FEdge = .all, _ length: CGFloat) -> Self {
        let value = YGValue(length)
        switch edge {
        case .all: yoga.margin = value
        case .left: yoga.marginLeft = value
        case .leading: yoga.marginStart = value
        case .right: yoga.marginRight = value
        case .trailing: yoga.marginEnd = value
        case .bottom: yoga.marginBottom = value
        case .top: yoga.marginTop = value
        case .horizontal: yoga.marginHorizontal = value
        case .vertical: yoga.marginVertical = value
        }
        return self
    }

    @discardableResult func margin(_ edge: [FEdge], _ length: CGFloat) -> Self {
        edge.forEach {
            _ = margin($0, length)
        }
        return self
    }
    
    @discardableResult func margin(_ edge: [FEdge], _ percent: FlexPercent) -> Self{
        edge.forEach {
            _ = margin($0, percent)
        }
        return self
    }

    @discardableResult func margin(_ insets: UIEdgeInsets) -> Self {
        _ = padding(.top, insets.top)
        _ = padding(.bottom, insets.bottom)
        _ = padding(.left, insets.left)
        _ = padding(.right, insets.right)

        return self
    }

    @available(iOS 11.0, *)
    @discardableResult func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> Self {
        _ = margin(.top, directionalInsets.top)
        _ = margin(.bottom, directionalInsets.bottom)
        _ = margin(.trailing, directionalInsets.trailing)
        _ = margin(.leading, directionalInsets.leading)

        return self
    }

    @discardableResult func borderWidth(_ all: CGFloat) -> Self {
        yoga.borderWidth = all
        return self
    }

    @discardableResult func borderWidth(_ edge: FEdge, _ length: CGFloat) -> Self {
        switch edge {
        case .all: yoga.borderWidth = length
        case .left: yoga.borderLeftWidth = length
        case .leading: yoga.borderStartWidth = length
        case .top: yoga.borderTopWidth = length
        case .bottom: yoga.borderBottomWidth = length
        case .right: yoga.borderRightWidth = length
        case .trailing: yoga.borderEndWidth = length

        case .horizontal:
            yoga.borderLeftWidth = length
            yoga.borderRightWidth = length

        case .vertical:
            yoga.borderTopWidth = length
            yoga.borderBottomWidth = length
        }
        return self
    }

    @discardableResult func left(_ left: CGFloat) -> Self {
        yoga.left = YGValue(left)
        return self
    }

    @discardableResult func top(_ top: CGFloat) -> Self {
        yoga.top = YGValue(top)
        return self
    }

    @discardableResult func right(_ right: CGFloat) -> Self {
        yoga.right = YGValue(right)
        return self
    }

    @discardableResult func bottom(_ bottom: CGFloat) -> Self {
        yoga.bottom = YGValue(bottom)
        return self
    }

    @discardableResult func leading(_ start: CGFloat) -> Self {
        yoga.start = YGValue(start)
        return self
    }

    @discardableResult func trailing(_ end: CGFloat) -> Self {
        yoga.end = YGValue(end)
        return self
    }

    @discardableResult func size(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        yoga.width(width)
        yoga.height(height)
        return self
    }

    @discardableResult func size(_ size: CGFloat) -> Self {
        yoga.width = YGValue(size)
        yoga.height = YGValue(size)
        return self
    }

    @discardableResult func size(_ size: CGSize) -> Self {
        yoga.width = YGValue(size.width)
        yoga.height = YGValue(size.height)
        return self
    }
    
    @discardableResult func size(width: FlexPercent?, height: FlexPercent?) -> Self {
        
        if let width = width {
            yoga.width(width)
        }
        
        if let height = height {
            yoga.height(height)
        }
        
        return self
    }
    
    @discardableResult func size(_ percent: FlexPercent) -> Self {
        yoga.width(percent)
        yoga.height(percent)

        return self
    }


    @discardableResult func size(minWidth: CGFloat? = nil, maxWidth: CGFloat? = nil, minHeight : CGFloat? = nil, maxHeight: CGFloat? = nil) -> Self {
        
        yoga.minWidth = valueOrUndefined(minWidth)
        yoga.maxWidth = valueOrUndefined(maxWidth)
        
        yoga.minHeight = valueOrUndefined(minHeight)
        yoga.maxHeight = valueOrUndefined(maxHeight)
        
        return self
    }
    
    @discardableResult func width(_ percent: FlexPercent) -> Self {
        yoga.width = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }
    @discardableResult func height(_ percent: FlexPercent) -> Self {
        yoga.height = YGValue(value: Float(percent.value), unit: .percent)
        return self
    }

    @discardableResult func width(_ width: CGFloat?) -> Self {
        yoga.width = valueOrAuto(width)
        return self
    }

    @discardableResult func height(_ height: CGFloat?) -> Self {
        yoga.height = valueOrAuto(height)
        return self
    }

    @discardableResult func aspectRatio(_ aspectRatio: CGFloat) -> Self {
        yoga.aspectRatio = aspectRatio
        return self
    }

    @discardableResult func direction(_ direction: FlexDirection) -> Self {
        yoga.flexDirection = direction.yogaValue
        return self
    }

    @discardableResult func mainAxis(_ mainAxis: MainAxisAlignment) -> Self {
        yoga.justifyContent = mainAxis.yogaValue
        return self
    }

    @discardableResult func crossAxis(_ crossAxis: CrossAxisAlignment) -> Self {
        yoga.alignItems = crossAxis.yogaValue
        return self
    }

    @discardableResult func alignContent(_ alignContent: AlignContent) -> Self {
        yoga.alignContent = alignContent.yogaValue
        return self
    }

    @discardableResult func position(_ position: PositionType) -> Self {
        yoga.position = position.yogaValue
        return self
    }

    @discardableResult func wrap(_ wrap: WrapType) -> Self {
        yoga.flexWrap = wrap.yogaValue
        return self
    }

    @discardableResult func flex(_ flex: CGFloat) -> Self {
        yoga.flex = flex
        return self
    }

    @discardableResult func expanded() -> Self {
        yoga.flex = 1
        return self
    }

    @discardableResult func grow(_ grow: CGFloat) -> Self {
        yoga.flexGrow = grow
        return self
    }

    @discardableResult func shrink(_ shrink: CGFloat) -> Self {
        yoga.flexShrink = shrink
        return self
    }

    @discardableResult func basis(_ basis: CGFloat) -> Self {
        yoga.flexBasis = YGValue(basis)
        return self
    }

    @discardableResult func inherit() -> Self {
        yoga.direction = .inherit
        return self
    }

    @discardableResult func ltr() -> Self {
        yoga.direction = .LTR
        return self
    }

    @discardableResult func rtl() -> Self {
        yoga.direction = .RTL
        return self
    }

    @discardableResult func alignSelf(_ alignSelf: AlignSelf) -> Self {
        yoga.alignSelf = alignSelf.yogaValue
        return self
    }

    var direction: FlexDirection {
        let yogaDirection: YGFlexDirection = yoga.flexDirection

        switch yogaDirection {
        case .column: return .column
        case .columnReverse: return .columnReverse
        case .row: return .row
        case .rowReverse: return .rowReverse
        default:
            return .column
        }
    }

    func applyLayout(preservingOrigin: Bool = true) {
        yoga.applyLayout(preservingOrigin: preservingOrigin)
    }

    func applyLayout(mode: LayoutMode = .fitContainer, preservingOrigin: Bool = true) {
        if case .fitContainer = mode {
            yoga.applyLayout(preservingOrigin: preservingOrigin)
        } else {
            yoga.applyLayout(preservingOrigin: preservingOrigin, dimensionFlexibility: mode == .adjustWidth ? YGDimensionFlexibility.flexibleWidth : YGDimensionFlexibility.flexibleHeight)
        }
    }

    var intrinsicSize: CGSize {
        return yoga.intrinsicSize
    }

    /*
     * sizeThatFits(with: CGSize(width: size.width, height: CGFloat.nan))
     */
    func sizeThatFits(with: CGSize) -> CGSize {
        return yoga.calculateLayout(with: with)
    }

    var numberOfChildren: UInt {
        return yoga.numberOfChildren
    }

    var isLeaf: Bool {
        return yoga.isLeaf
    }

    var isDirty: Bool {
        return yoga.isDirty
    }

    func markDirty() {
        yoga.markDirty()
    }

    @discardableResult
    func gap(_ gap: CGFloat) -> Self {
        yoga.gap = gap
        return self
    }

    @discardableResult
    func rowGap(_ gap: CGFloat) -> Self {
        yoga.rowGap = gap
        return self
    }

    @discardableResult
    func columnGap(_ gap: CGFloat) -> Self {
        yoga.columnGap = gap
        return self
    }
    
}

func valueOrUndefined(_ value: CGFloat?) -> YGValue {
    if let value = value {
        return YGValue(value)
    } else {
        return YGValueUndefined
    }
}

func valueOrAuto(_ value: CGFloat?) -> YGValue {
    if let value = value {
        return YGValue(value)
    } else {
        return YGValueAuto
    }
}


public extension FlexLayout where Self: YGLayout {
    // 属性
    var yoga: YGLayout {
        return self
    }
}

/// 实现协议
/// YGLayout拥有链式功能
extension YGLayout: FlexLayout {
    public var yoga: YGLayout {
        return self
    }
}

// MARK: Enums

public enum FEdge: Int8 {
    case top
    case left
    case right
    case bottom
    case trailing
    case leading
    case all
    case horizontal
    case vertical
}

/** 主轴方向
 */
public enum FlexDirection {
    /// Default value. The flexible items are displayed vertically, as a column.
    case column
    /// Same as column, but in reverse order
    case columnReverse
    /// The flexible items are displayed horizontally, as a row.
    case row
    /// Same as row, but in reverse order
    case rowReverse

    var yogaValue: YGFlexDirection {
        switch self {
        case .column: return YGFlexDirection.column
        case .columnReverse: return YGFlexDirection.columnReverse
        case .row: return YGFlexDirection.row
        case .rowReverse: return YGFlexDirection.rowReverse
        }
    }
}

/* 主轴方向布局方式
 * Default value: start
 */
public enum MainAxisAlignment {
    /// Default value. Items are positioned at the beginning of the container.
    case start
    /// Items are positioned at the center of the container
    case center
    /// Items are positioned at the end of the container
    case end
    /// Items are positioned with space between the lines
    case spaceBetween
    /// Items are positioned with space before, between, and after the lines
    case spaceAround
    /// Items are positioned with space distributed evenly, items have equal space around them.
    case spaceEvenly

    var yogaValue: YGJustify {
        switch self {
        case .start: return YGJustify.flexStart
        case .center: return YGJustify.center
        case .end: return YGJustify.flexEnd
        case .spaceBetween: return YGJustify.spaceBetween
        case .spaceAround: return YGJustify.spaceAround
        case .spaceEvenly: return YGJustify.spaceEvenly
        }
    }
}

/* 次轴方向布局方式
 * Default value:stretch
 */
public enum CrossAxisAlignment {
    /// Default value. Lines stretch to take up the remaining space
    case stretch
    /// Lines are packed toward the start of the flex container
    case start
    /// Lines are packed toward the center of the flex container
    case center
    /// Lines are packed toward the end of the flex container
    case end
    /// Lines are evenly distributed in the flex container
    case spaceBetween
    /// Lines are evenly distributed in the flex container, with half-size spaces on either end    Play it »
    case spaceAround

    var yogaValue: YGAlign {
        switch self {
        case .stretch: return YGAlign.stretch
        case .start: return YGAlign.flexStart
        case .center: return YGAlign.center
        case .end: return YGAlign.flexEnd
        case .spaceBetween: return YGAlign.spaceBetween
        case .spaceAround: return YGAlign.spaceAround
        }
    }
}

/** 次轴方向多行布局方式
 */
public enum AlignContent {
    /// Default value. Lines stretch to take up the remaining space
    case stretch
    /// Lines are packed toward the start of the flex container
    case start
    /// Lines are packed toward the center of the flex container
    case center
    /// Lines are packed toward the end of the flex container
    case end
    /// Lines are evenly distributed in the flex container
    case spaceBetween
    /// Lines are evenly distributed in the flex container, with half-size spaces on either end    Play it »
    case spaceAround

    var yogaValue: YGAlign {
        switch self {
        case .stretch: return YGAlign.stretch
        case .start: return YGAlign.flexStart
        case .center: return YGAlign.center
        case .end: return YGAlign.flexEnd
        case .spaceBetween: return YGAlign.spaceBetween
        case .spaceAround: return YGAlign.spaceAround
        }
    }
}

public enum WrapCrossAlignment {
    case start
    /// Lines are packed toward the center of the flex container
    case center
    /// Lines are packed toward the end of the flex container
    case end

    var crossAxis: CrossAxisAlignment {
        switch self {
        case .start: return CrossAxisAlignment.start
        case .center: return CrossAxisAlignment.center
        case .end: return CrossAxisAlignment.end
        }
    }
}

/**
 */
public enum AlignSelf {
    /// Default. The element inherits its parent container's align-items property, or "stretch" if it has no parent container
    case auto
    /// The element is positioned to fit the container
    case stretch
    /// The element is positioned at the beginning of the container
    case start
    /// The element is positioned at the center of the container
    case center
    /// The element is positioned at the end of the container
    case end
    /// The element is positioned at the baseline of the container
    case baseline

    var yogaValue: YGAlign {
        switch self {
        case .auto: return YGAlign.auto
        case .stretch: return YGAlign.stretch
        case .start: return YGAlign.flexStart
        case .center: return YGAlign.center
        case .end: return YGAlign.flexEnd
        case .baseline: return YGAlign.baseline
        }
    }
}

/**
 */
public enum WrapType {
    /// Default value. Specifies that the flexible items will not wrap
    case noWrap
    /// Specifies that the flexible items will wrap if necessary
    case wrap
    /// Specifies that the flexible items will wrap, if necessary, in reverse order
    case wrapReverse

    var yogaValue: YGWrap {
        switch self {
        case .noWrap: return YGWrap.noWrap
        case .wrap: return YGWrap.wrap
        case .wrapReverse: return YGWrap.wrapReverse
        }
    }
}

/**
 */
public enum PositionType {
    /// Default value.
    case relative
    /// Positioned absolutely in regards to its container. The item is positionned using properties top, bottom, left, right, start, end.
    case absolute

    case `static`

    var yogaValue: YGPositionType {
        switch self {
        case .relative: return YGPositionType.relative
        case .absolute: return YGPositionType.absolute
        case .static: return YGPositionType.static
        }
    }
}

/**
 Defines how the `applyLayout(mode:)` method layout its flex items.
 */
public enum LayoutMode {
    /// This is the default mode when no parameter is specified. Children are layouted **inside** the container's size (width and height).
    case fitContainer
    /// In this mode, children are layouted **using only the container's width**. The container's height will be adjusted to fit the flexbox's children
    case adjustHeight
    /// In this mode, children are layouted **using only the container's height**. The container's width will be adjusted to fit the flexbox's children
    case adjustWidth
}

public enum FAxis {
    case horizontal
    case vertical

    var yogaValue: YGFlexDirection {
        switch self {
        case .horizontal:
            return .row
        case .vertical:
            return .column
        }
    }
}


public struct FlexPercent {
    let value: CGFloat
}

postfix operator %
public postfix func % (v: CGFloat) -> FlexPercent {
    return FlexPercent(value: v)
}

public postfix func % (v: Int) -> FlexPercent {
    return FlexPercent(value: CGFloat(v))
}

prefix operator -
public prefix func - (p: FlexPercent) -> FlexPercent {
    return FlexPercent(value: -p.value)
}
