//
//  Text.swift
//  FlexKit
//
//  Created by yun on 2023/8/19.
//

import UIKit

public class Text: UILabel {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        flex.enabled(true)
//        flex.markDirty()
    }

    public convenience init(_ text: String?) {
        self.init(frame: .zero)
        self.text = text
    }

    public convenience init(_ attr: NSAttributedString?) {
        self.init(frame: .zero)
        attributedText = attr
    }

    public convenience init(_ state: UState<String?>) {
        self.init(state.wrappedValue)
        state.listen { value in
            self.text(value)
        }
    }

    public convenience init(_ state: UState<String>) {
        self.init(state.wrappedValue)
        state.listen { value in
            self.text(value)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Text: FlexLayout {}
extension Text: FlexViewChain {}

public extension Text {
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        flex.markDirty()
        return self
    }

    @discardableResult
    func text(_ text: NSAttributedString?) -> Self {
        attributedText = text
        flex.markDirty()
        return self
    }

    @discardableResult
    func numberOfLines(_ line: Int) -> Self {
        numberOfLines = line
        return self
    }

    @discardableResult
    func textColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }

    @discardableResult
    func bold(_ fontSize: CGFloat) -> Self {
        font = UIFont.boldSystemFont(ofSize: fontSize)
        return self
    }

    @discardableResult
    func fontSize(_ fontSize: CGFloat, weight: UIFont.Weight?) -> Self {
        if let weight = weight {
            font = .systemFont(ofSize: fontSize, weight: weight)

        } else {
            font = .systemFont(ofSize: fontSize)
        }

        return self
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
}
