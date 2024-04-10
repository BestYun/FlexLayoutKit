//
//  FViweChainKit.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/8/1.
//

import Foundation
import UIKit

@dynamicMemberLookup
public struct UViewChainWrapper<Subject: UIView>: FlexboxView {
    

    public var view: Subject

    public init(_ view: Subject) {
        self.view = view
    }
    
    public var flexBaseView: UIView {
        self.view
    }


    public subscript<Value>(
        dynamicMember keyPath: WritableKeyPath<Subject, Value>
    ) -> (Value) -> UViewChainWrapper<Subject> {
        var subject = self.view
        return { value in
            subject[keyPath: keyPath] = value
            return UViewChainWrapper(subject)
        }
    }

    @discardableResult
    public func apply(subject: (Subject) -> Void) -> Subject {
        subject(view)
        return view
    }
}


public protocol UViewChainWrapperCompatible {
    associatedtype T: UIView
    var modifier: UViewChainWrapper<T> { get }
}

public extension UViewChainWrapperCompatible where Self: UIView {
    var modifier: UViewChainWrapper<Self> {
        return UViewChainWrapper(self)
    }
}

//
extension UIView: UViewChainWrapperCompatible {
    
}


