//
//  UState.swift
//  FlexKit
//
//  Created by yun on 2023/9/2.
//

import Foundation
/*
 *
 * https://github.com/MihaelIsaev/UIKitPlus/blob/master/Classes/Structs/UState.swift
 */
public protocol AnyState: AnyObject {
    func listen(_ listener: @escaping () -> Void)
}

public protocol Stateable: AnyState {
    associatedtype Value

    var wrappedValue: Value { get set }

    func beginTrigger(_ trigger: @escaping () -> Void)
    func endTrigger(_ trigger: @escaping () -> Void)
    func listen(_ listener: @escaping (_ old: Value, _ new: Value) -> Void)
    func listen(_ listener: @escaping (_ value: Value) -> Void)
    func listen(_ listener: @escaping () -> Void)
}

@propertyWrapper
open class UState<Value>: Stateable {
    private var _originalValue: Value
    private var _wrappedValue: Value
    public var wrappedValue: Value {
        get { _wrappedValue }
        set {
            let oldValue = _wrappedValue
            _wrappedValue = newValue
            for trigger in beginTriggers {
                trigger()
            }
            for listener in listeners {
                listener(oldValue, newValue)
            }
            for trigger in endTriggers {
                trigger()
            }
        }
    }

    public var projectedValue: UState<Value> { self }

    init(_ stateA: AnyState, _ stateB: AnyState, _ expression: @escaping () -> Value) {
        let value = expression()
        _originalValue = value
        _wrappedValue = value
        stateA.listen {
            self.wrappedValue = expression()
        }
        stateB.listen {
            self.wrappedValue = expression()
        }
    }

    init<A, B>(_ stateA: UState<A>, _ stateB: UState<B>, _ expression: @escaping (A, B) -> Value) {
        let value = expression(stateA.wrappedValue, stateB.wrappedValue)
        _originalValue = value
        _wrappedValue = value
        stateA.listen {
            self.wrappedValue = expression(stateA.wrappedValue, stateB.wrappedValue)
        }
        stateB.listen {
            self.wrappedValue = expression(stateA.wrappedValue, stateB.wrappedValue)
        }
    }

    init<A, B>(_ stateA: UState<A>, _ stateB: UState<B>, _ expression: @escaping (CombinedDeprecatedResult<A, B>) -> Value) {
        let value = expression(.init(left: stateA.wrappedValue, right: stateB.wrappedValue))
        _originalValue = value
        _wrappedValue = value
        stateA.listen {
            self.wrappedValue = expression(.init(left: stateA.wrappedValue, right: stateB.wrappedValue))
        }
        stateB.listen {
            self.wrappedValue = expression(.init(left: stateA.wrappedValue, right: stateB.wrappedValue))
        }
    }

    public init(wrappedValue value: Value) {
        _originalValue = value
        _wrappedValue = value
    }

    public init(_ stateA: AnyState, _ expression: @escaping () -> Value) {
        let value = expression()
        _originalValue = value
        _wrappedValue = value
        stateA.listen {
            self.wrappedValue = expression()
        }
    }

    public init<A>(_ stateA: UState<A>, _ expression: @escaping (A) -> Value) {
        let value = expression(stateA.wrappedValue)
        _originalValue = value
        _wrappedValue = value
        stateA.listen {
            self.wrappedValue = expression(stateA.wrappedValue)
        }
    }

    public func reset() {
        let oldValue = _wrappedValue
        _wrappedValue = _originalValue
        for trigger in beginTriggers {
            trigger()
        }
        for listener in listeners {
            listener(oldValue, _wrappedValue)
        }
        for trigger in endTriggers {
            trigger()
        }
    }

    public func removeAllListeners() {
        beginTriggers.removeAll()
        endTriggers.removeAll()
        listeners.removeAll()
    }

    public typealias Trigger = () -> Void
    public typealias Listener = (_ old: Value, _ new: Value) -> Void
    public typealias SimpleListener = (_ value: Value) -> Void

    private var beginTriggers: [Trigger] = []
    private var endTriggers: [Trigger] = []
    private var listeners: [Listener] = []

    public func beginTrigger(_ trigger: @escaping Trigger) {
        beginTriggers.append(trigger)
    }

    public func endTrigger(_ trigger: @escaping Trigger) {
        endTriggers.append(trigger)
    }

    public func listen(_ listener: @escaping Listener) {
        listeners.append(listener)
    }

    public func listen(_ listener: @escaping SimpleListener) {
        listeners.append { _, new in listener(new) }
    }

    public func listen(_ listener: @escaping () -> Void) {
        listeners.append { _, _ in listener() }
    }

    public func merge(with UState: UState<Value>) {
        wrappedValue = UState.wrappedValue
        var justSetExternal = false
        var justSetInternal = false
        UState.listen { [weak self] new in
            guard !justSetInternal else { return }
            justSetExternal = true
            self?.wrappedValue = new
            justSetExternal = false
        }
        listen { [weak UState] new in
            guard !justSetExternal else { return }
            justSetInternal = true
            UState?.wrappedValue = new
            justSetInternal = false
        }
    }

    public func and<V>(_ UState: UState<V>) -> CombinedState<Value, V> {
        CombinedState(left: projectedValue, right: UState)
    }
}

public class CombinedState<A, B> {
    let _left: UState<A>
    let _right: UState<B>
    public var left: A { _left.wrappedValue }
    public var right: B { _right.wrappedValue }

    init(left: UState<A>, right: UState<B>) {
        _left = left
        _right = right
    }

    public func map<Result>(_ expression: @escaping () -> Result) -> UState<Result> {
        .init(_left, _right, expression)
    }

    public func map<Result>(_ expression: @escaping (A, B) -> Result) -> UState<Result> {
        .init(_left, _right, expression)
    }
}

public struct CombinedDeprecatedResult<A, B> {
    public let left: A
    public let right: B
}
