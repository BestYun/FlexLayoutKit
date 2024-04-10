//
//  Button.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/9/11.
//

import UIKit

//Button("") {
//    print("click")
//}

//Button {
//    
//} onTap {
//    
//}

public class Button: UIButton, FlexboxLayout, UViewChain {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        flex.enabled(true)
        flex.markDirty()
    }

    public convenience init(_ title: String?) {
        self.init(frame: .zero)
        self.title(title)
    }

    public convenience init(image: UIImage?) {
        self.init(frame: .zero)
        self.image(image)
    }

    public convenience init(backgroundImage: UIImage?) {
        self.init(frame: .zero)
        self.backgroundImage(backgroundImage)
    }

    public convenience init(_ state: UState<String?>) {
        self.init(state.wrappedValue)
        state.listen { value in
            self.title(value)
        }
    }

    public convenience init(_ state: UState<String>) {
        self.init(state.wrappedValue)
        state.listen { value in
            self.title(value)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Button {
    @discardableResult func title(_ title: String?, for State: UIControl.State = .normal) -> Self {
        setTitle(title, for: State)
        markDirty()
        return self
    }

    @discardableResult func titleColor(_ color: UIColor?, for State: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: State)
        return self
    }

    @discardableResult func font(_ font: UIFont) -> Self {
        titleLabel?.font = font
        markDirty()
        return self
    }

    @discardableResult func image(_ image: UIImage?, for State: UIControl.State = .normal) -> Self {
        setImage(image, for: State)
        markDirty()
        return self
    }

    @discardableResult func backgroundImage(_ image: UIImage?, for State: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: State)
        markDirty()
        return self
    }

    @discardableResult func contentEdgeInsets(_ contentEdgeInsets: UIEdgeInsets) -> Self {
        self.contentEdgeInsets = contentEdgeInsets
        markDirty()
        return self
    }

    @discardableResult func titleEdgeInsets(_ titleEdgeInsets: UIEdgeInsets) -> Self {
        self.titleEdgeInsets = titleEdgeInsets
        markDirty()
        return self
    }

    @discardableResult func imageEdgeInsets(_ imageEdgeInsets: UIEdgeInsets) -> Self {
        self.imageEdgeInsets = imageEdgeInsets
        markDirty()
        return self
    }

    @discardableResult func reversesTitleShadowWhenHighlighted(_ reversesTitleShadowWhenHighlighted: Bool) -> Self {
        self.reversesTitleShadowWhenHighlighted = reversesTitleShadowWhenHighlighted
        return self
    }

    @discardableResult func adjustsImageWhenHighlighted(_ adjustsImageWhenHighlighted: Bool) -> Self {
        self.adjustsImageWhenHighlighted = adjustsImageWhenHighlighted
        return self
    }

    @discardableResult func adjustsImageWhenDisabled(_ adjustsImageWhenDisabled: Bool) -> Self {
        self.adjustsImageWhenDisabled = adjustsImageWhenDisabled
        return self
    }

    @discardableResult func showsTouchWhenHighlighted(_ showsTouchWhenHighlighted: Bool) -> Self {
        self.showsTouchWhenHighlighted = showsTouchWhenHighlighted
        return self
    }

    @discardableResult func tintColor(_ tintColor: UIColor!) -> Self {
        self.tintColor = tintColor
        return self
    }

    @available(iOS 14.0, *)
    @discardableResult func role(_ role: UIButton.Role) -> Self {
        self.role = role
        return self
    }

    @available(iOS 13.4, *)
    @discardableResult func isPointerInteractionEnabled(_ isPointerInteractionEnabled: Bool) -> Self {
        self.isPointerInteractionEnabled = isPointerInteractionEnabled
        return self
    }

    @discardableResult func titleShadowColor(_ color: UIColor?, for State: UIControl.State = .normal) -> Self {
        setTitleShadowColor(color, for: State)
        return self
    }
}
