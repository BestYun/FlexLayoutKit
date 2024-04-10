//
//  FlexDSL.swift
//  FlexLayoutKit
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

public struct FlexDSL<BaseView: UIView>: FlexboxView {
    private let view: BaseView
    init(view: BaseView) {
        self.view = view
        view.yoga.isEnabled = true
    }
    public var flexBaseView: UIView { view }
}

// 增加链式
extension FlexDSL: UViewChainWrapperCompatible {
    public var modifier: UViewChainWrapper<BaseView> {
        return UViewChainWrapper(view)
    }
}

/// 操作view
public extension FlexDSL {
    
    @discardableResult
    func apply(_ base: (BaseView) -> Void) -> Self {
        base(view)
        return self
    }
    
    @discardableResult
    func addItems(@FlexboxViewBuilder subviews: () -> [FlexboxView])-> Self  {
        subviews().forEach { item in
            let view = item.flexBaseView
            if let spacer = view as? Spacer {
                if direction == .column || direction == .columnReverse {
                    spacer.flex.height(spacer.spacing)
                } else {
                    spacer.flex.width(spacer.spacing)
                }
            }
            self.view.addSubview(view)
        }
        return self
    }
    
    @discardableResult
    func addItems(subviews: [FlexboxView])-> Self  {
        subviews.forEach { item in
            let view = item.flexBaseView
            if let spacer = view as? Spacer {
                if direction == .column || direction == .columnReverse {
                    spacer.flex.height(spacer.spacing)
                } else {
                    spacer.flex.width(spacer.spacing)
                }
            }
            self.view.addSubview(view)
        }
        return self
    }
    
    @discardableResult
    func addItem(_ itemView: FlexboxView) -> Self {
        view.addSubview(itemView.flexBaseView)
        return self
    }
    
}

/// yoga相关
public extension FlexDSL {
    @discardableResult
    func makeLayout(_ layout: (YGLayout) -> Void) -> Self {
        layout(yoga)
        return self
    }
}

extension FlexDSL: FlexboxLayout {
    public var yoga: YGLayout {
        return view.yoga
    }
}
