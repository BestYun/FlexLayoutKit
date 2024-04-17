//
//  FlexViewChain.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/8/19.
//

import Foundation
import UIKit
/// uiview 链式实现
public protocol UViewChain {
    func backgroundColor(_ color: UIColor) -> Self
    func cornerRadius(_ radius: CGFloat) -> Self
    @available(iOS 11.0, *)
    func maskedCorners(_ maskedCorners: CACornerMask) -> Self
    @available(iOS 13.0, *)
    func cornerCurve(_ cornerCurve: CALayerCornerCurve) -> Self
    func masksToBounds(_ masksToBounds: Bool) -> Self

    func borderWidth(_ borderWidth: CGFloat) -> Self
    func borderColor(_ borderColor: UIColor?) -> Self
    func border(color: UIColor, width: CGFloat) -> Self
    func shadowColor(_ shadowColor: UIColor?) -> Self
    func shadowOpacity(_ shadowOpacity: Float) -> Self
    func shadowOffset(_ shadowOffset: CGSize) -> Self
    func shadowRadius(_ shadowRadius: CGFloat) -> Self
    func shadowPath(_ shadowPath: CGPath?) -> Self

    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self
    func tag(_ tag: Int) -> Self
    func alpha(_ alpha: CGFloat) -> Self
    func isOpaque(_ isOpaque: Bool) -> Self
    func isHidden(_ isHidden: Bool) -> Self
    func clipsToBounds(_ clipsToBounds: Bool) -> Self

    func contentMode(_ contentMode: UIView.ContentMode) -> Self
    func mask(_ mask: UIView?) -> Self
    func onTap(_ click: @escaping () -> Void) -> Self
}

public extension UViewChain where Self: UIView {
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult
    func cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        clipsToBounds = true
        return self
    }

    @discardableResult
    func masksToBounds(_ masksToBounds: Bool) -> Self {
        layer.masksToBounds = masksToBounds
        return self
    }

    @available(iOS 11.0, *)
    @discardableResult
    func maskedCorners(_ maskedCorners: CACornerMask) -> Self {
        layer.maskedCorners = maskedCorners
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult
    func cornerCurve(_ cornerCurve: CALayerCornerCurve) -> Self {
        layer.cornerCurve = cornerCurve
        return self
    }

    @discardableResult
    func borderWidth(_ borderWidth: CGFloat) -> Self {
        layer.borderWidth = borderWidth
        return self
    }

    @discardableResult
    func borderColor(_ borderColor: UIColor?) -> Self {
        layer.borderColor = borderColor?.cgColor
        return self
    }

    @discardableResult
    func border(color: UIColor, width: CGFloat) -> Self {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        return self
    }

    @discardableResult
    func shadowColor(_ shadowColor: UIColor?) -> Self {
        layer.shadowColor = shadowColor?.cgColor
        return self
    }

    @discardableResult
    func shadowOpacity(_ shadowOpacity: Float) -> Self {
        layer.shadowOpacity = shadowOpacity
        return self
    }

    @discardableResult
    func shadowOffset(_ shadowOffset: CGSize) -> Self {
        layer.shadowOffset = shadowOffset
        return self
    }

    @discardableResult
    func shadowRadius(_ shadowRadius: CGFloat) -> Self {
        layer.shadowRadius = shadowRadius
        return self
    }

    @discardableResult
    func shadowPath(_ shadowPath: CGPath?) -> Self {
        layer.shadowPath = shadowPath
        return self
    }

    @discardableResult
    func isUserInteractionEnabled(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabled = isUserInteractionEnabled
        return self
    }

    @discardableResult
    func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }

    @discardableResult
    func clipsToBounds(_ clipsToBounds: Bool) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }

    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }

    @discardableResult
    func isOpaque(_ isOpaque: Bool) -> Self {
        self.isOpaque = isOpaque
        return self
    }

    @discardableResult
    func mask(_ mask: UIView?) -> Self {
        self.mask = mask
        return self
    }

    @discardableResult
    func contentMode(_ contentMode: UIView.ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }

    @discardableResult
    func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }

    @discardableResult
    func onTap(_ click: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true

        let actionHandler = TapActionHandler(action: click)
        let tapGesture = UITapGestureRecognizer(target: actionHandler, action: #selector(TapActionHandler.executeAction))
        tapGesture.tapActionHandler = actionHandler
        tapGesture.delegate = actionHandler
        if let gestureRecognizers = gestureRecognizers {
            for gesture in gestureRecognizers where gesture is UITapGestureRecognizer {
                removeGestureRecognizer(gesture)
            }
        }
        addGestureRecognizer(tapGesture)

        return self
    }
}

public class TapActionHandler: NSObject, UIGestureRecognizerDelegate {
    let action: () -> Void
    public init(action: @escaping () -> Void) {
        self.action = action
    }

    @objc func executeAction() {
        action()
    }

    public func gestureRecognizer(_: UIGestureRecognizer, shouldReceive _: UITouch) -> Bool {
        return true
    }
}

public extension UIGestureRecognizer {
    static var tapActionHandlerAssociatedKey = "TapActionHandlerAssociatedKey"
    var tapActionHandler: TapActionHandler? {
        get {
#if swift(>=5.9)
            withUnsafePointer(to: &Self.tapActionHandlerAssociatedKey) {
               return objc_getAssociatedObject(self, $0)
            } as? TapActionHandler
#else
            objc_getAssociatedObject(self, &Self.tapActionHandlerAssociatedKey) as? TapActionHandler
#endif
        }
        set {
#if swift(>=5.9)

            withUnsafePointer(to: &Self.tapActionHandlerAssociatedKey) {
                objc_setAssociatedObject(self, $0, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
#else
            objc_setAssociatedObject(self, &Self.tapActionHandlerAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
#endif
        }
    }
}
