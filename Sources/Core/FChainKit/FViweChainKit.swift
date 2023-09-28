//
//  FViweChainKit.swift
//  FlexKit
//
//  Created by yun on 2023/8/1.
//

import Foundation
import UIKit

@dynamicMemberLookup
public struct FViewChainWrapper<Subject> {
    public var view: Subject

    public init(_ view: Subject) {
        self.view = view
    }

    public subscript<Value>(
        dynamicMember keyPath: WritableKeyPath<Subject, Value>
    ) -> (Value) -> FViewChainWrapper<Subject> {
        var subject = self.view
        return { value in
            subject[keyPath: keyPath] = value
            return FViewChainWrapper(subject)
        }
    }
    @discardableResult
    public func apply(subject:(Subject)->Void) -> Subject{
        subject(view)
        return view
    }
}

public protocol FViewChainWrapperCompatible {
    associatedtype T
    var modifier: FViewChainWrapper<T> { get }
}

public extension FViewChainWrapperCompatible where Self: UIView {
    var modifier: FViewChainWrapper<Self> {
        return FViewChainWrapper(self)
    }
}

extension UIView: FViewChainWrapperCompatible {}
