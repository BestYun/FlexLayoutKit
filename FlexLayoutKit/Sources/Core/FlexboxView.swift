//
//  Flexbox.swift
//  FlexLayoutKit
//
//  Created by yun on 2024/3/31.
//

import Foundation
///UIView FlexDSL UViewChainWrapper YGLayout这四个实现FlexboxView
public protocol FlexboxView {
    var flexBaseView: UIView {
        get
    }
    
//    func bindToBoxView(_ view: inout Self?) -> FlexboxView
}

public extension FlexboxView {
//    @discardableResult
//    func bindToBoxView(_ view: inout Self?) -> FlexboxView {
//        view = self
//        return self
//    }

}

public extension FlexboxView where Self: UIView{
    var flexBaseView: UIView {
        self
    }
}


extension UIView: FlexboxView {

}
