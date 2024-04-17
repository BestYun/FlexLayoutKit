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
    
    @discardableResult
    func bindTo(_ view: inout Self?) -> Self {
        view = self
        return self
    }
    
}

extension UIView: FlexDSLProtocol {}

public struct FlexDSL<BaseView: UIView>: FlexboxView {
    public let view: BaseView
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
    
    @discardableResult
    func insertItems(at: Int,@FlexboxViewBuilder subviews: () -> [FlexboxView])-> Self  {
        var index = at
        subviews().forEach { item in
            let view = item.flexBaseView
            if let spacer = view as? Spacer {
                if direction == .column || direction == .columnReverse {
                    spacer.flex.height(spacer.spacing)
                } else {
                    spacer.flex.width(spacer.spacing)
                }
            }
            self.view.insertSubview(view, at: index)
            index = index + 1
        }
        return self
    }
    
    @discardableResult
    ///添加subview在belowSubview的下面
    func insertItems(belowSubview: UIView, @FlexboxViewBuilder subviews: () -> [FlexboxView])-> Self  {
        var firstView: UIView = belowSubview
        
        subviews().forEach { item in
            let view = item.flexBaseView
            if let spacer = view as? Spacer {
                if direction == .column || direction == .columnReverse {
                    spacer.flex.height(spacer.spacing)
                } else {
                    spacer.flex.width(spacer.spacing)
                }
            }
            self.view.insertSubview(view, aboveSubview: firstView)

            firstView = view

        }
        return self
    }    
    
    @discardableResult
    //insertSubview(view:UIView,belowSubview siblingSubview:UIView)：会导致subview在subviews中排在belowSubview前面,在yoga中
    ///添加subview在aboveSubview上面
    func insertItems(aboveSubview: UIView, @FlexboxViewBuilder subviews: () -> [FlexboxView])-> Self  {
        subviews().forEach { item in
            let view = item.flexBaseView
            if let spacer = view as? Spacer {
                if direction == .column || direction == .columnReverse {
                    spacer.flex.height(spacer.spacing)
                } else {
                    spacer.flex.width(spacer.spacing)
                }
            }
            self.view.insertSubview(view, belowSubview: aboveSubview)
        }
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
