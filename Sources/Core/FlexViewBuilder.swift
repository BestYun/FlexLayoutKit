//
//  FlexViewBuilder.swift
//  FlexKit
//
//  Created by yun on 2023/7/26.
//

import Foundation
import UIKit

@resultBuilder
public enum FlexViewBuilder {
    public typealias Expression = UIView
    public typealias Component = [UIView]

    public static func buildExpression(_ expression: Expression) -> Component {
        return [expression]
    }

    public static func buildBlock() -> Component { [] }

    public static func buildBlock(_ components: Component...) -> Component {
        return components.flatMap { $0 }
    }

    public static func buildBlock(_ components: UIView...) -> Component {
        return components.map { $0 }
    }

    public static func buildOptional(_ component: Component?) -> Component {
        return component ?? []
    }

    public static func buildEither(first component: Component) -> Component {
        return component
    }

    public static func buildEither(second component: Component) -> Component {
        return component
    }

    public static func buildArray(_ components: [Component]) -> Component {
        return Array(components.joined())
    }
}
