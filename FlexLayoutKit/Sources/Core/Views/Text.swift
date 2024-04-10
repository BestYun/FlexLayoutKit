//
//  Text.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/8/19.
//

import UIKit
///paddingLeft和right无效
public class Text: UILabel, FlexboxLayout, UViewChain {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        flex.enabled(true)
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
    
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    
}

public extension Text {
    @discardableResult
    func text(_ text: String?) -> Self {
        if self.text != text {
            self.text = text
            flex.markDirty()
        }
        return self
    }

    @discardableResult
    func text(_ text: NSAttributedString?) -> Self {
        attributedText = text
        flex.markDirty()
        return self
    }

    @discardableResult
    func textColor(_ textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }

    @discardableResult
    func fontSize(_ fontSize: CGFloat, weight: UIFont.Weight? = nil) -> Self {
        if let weight = weight {
            font = .systemFont(ofSize: fontSize, weight: weight)

        } else {
            font = .systemFont(ofSize: fontSize)
        }
        flex.markDirty()

        return self
    }

    @discardableResult
    func font(_ font: UIFont) -> Self {
        self.font = font
        flex.markDirty()

        return self
    }

    @discardableResult
    func bold(_ fontSize: CGFloat) -> Self {
        font = UIFont.boldSystemFont(ofSize: fontSize)
        flex.markDirty()

        return self
    }

    @discardableResult
    func medium(_ fontSize: CGFloat) -> Self {
        font = .systemFont(ofSize: fontSize, weight: .medium)
        flex.markDirty()

        return self
    }

    @discardableResult
    func numberOfLines(_ line: Int) -> Self {
        numberOfLines = line
        flex.markDirty()

        return self
    }

    @discardableResult
    func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }
}
