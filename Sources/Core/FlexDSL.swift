//
//  FlexDSL.swift
//  FlexKit
//
//  Created by yun on 2023/7/30.
//


import UIKit

public protocol FlexDSLProtocol {}

public extension FlexDSLProtocol where Self: UIView {
    var flex: FlexDSL<Self> {
        return FlexDSL(view: self)
    }
}

extension UIView: FlexDSLProtocol {}

public struct FlexDSL<BaseView: UIView> {
    public let view: BaseView
    init(view: BaseView) {
        self.view = view
        view.yoga.isEnabled = true
    }
}

// 增加链式
extension FlexDSL: FViewChainWrapperCompatible {
    public var modifier: FViewChainWrapper<BaseView> {
        return FViewChainWrapper(view)
    }
}

/// 操作view
public extension FlexDSL {
    @discardableResult
    func apply(_ self: (BaseView) -> Void) -> BaseView {
        self(view)
        return view
    }
    @discardableResult
    func addItems(@FlexViewBuilder subviews: () -> [UIView])-> BaseView  {
        subviews().forEach { item in
            item.flex.enabled(true)
            self.view.addSubview(item)
        }
        return view
    }
    @discardableResult
    func addItem(_ itemView: UIView) -> BaseView {
        itemView.yoga.enabled(true)
        view.addSubview(itemView)
        return view

    }
}

/// yoga相关
public extension FlexDSL {
    @discardableResult
    func makeLayout(_ layout: (YGLayout) -> Void) -> BaseView {
        layout(yoga)
        return view
    }
}

extension FlexDSL: FlexLayout {
    public var yoga: YGLayout {
        return view.yoga
    }
}
