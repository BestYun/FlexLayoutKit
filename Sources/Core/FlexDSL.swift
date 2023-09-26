//
//  FlexDSL.swift
//  FlexKit
//
//  Created by yun on 2023/7/30.
//


import UIKit
//import YogaKit

public protocol FlexDSLProtocol {}

public extension FlexDSLProtocol where Self: UIView {
    var flex: FlexDSL<Self> {
        return FlexDSL(view: self)
    }
}

extension UIView: FlexDSLProtocol {}

public struct FlexDSL<BaseView: UIView> {
    let view: BaseView
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

    func addItems(@FlexViewBuilder subviews: () -> [UIView]) {
        subviews().forEach { item in
            item.yoga.enabled(true)
            self.view.addSubview(item)
        }
    }

    func addItem(_ itemView: UIView) {
        itemView.yoga.enabled(true)
        view.addSubview(itemView)
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
