//
//  FlexboxViewBuilder.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/7/26.
//

import Foundation
import UIKit

@resultBuilder
public enum FlexboxViewBuilder {
    public typealias Expression = FlexboxView
    public typealias Component = [FlexboxView]

    public static func buildExpression(_ expression: Expression) -> Component {
        return [expression]
    }

    public static func buildBlock(_ body: FlexboxView) -> Component { [body] }

    /// Component...可变参数
    public static func buildBlock(_ components: Component...) -> Component {
        return components.flatMap { $0 }
    }

    // 使用包含if不包含else的
    public static func buildOptional(_ component: Component?) -> Component {
        return component ?? []
    }

    // if else
    public static func buildEither(first component: Component) -> Component {
        return component
    }

    // if else
    public static func buildEither(second component: Component) -> Component {
        return component
    }

    // for in
    public static func buildArray(_ components: [Component]) -> Component {
        return Array(components.joined())
    }
}
