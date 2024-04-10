//
//  Applyable.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/8/3.
//

import UIKit

public protocol Applyable: AnyObject {}
/// 针对UIView
public extension Applyable where Self: UIView {
    @discardableResult
    @inlinable
    func apply(_ view: (Self) -> Void) -> Self {
        view(self)
        return self
    }

}

extension UIView: Applyable {}
