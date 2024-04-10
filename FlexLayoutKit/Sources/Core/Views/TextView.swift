//
//  TextView.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/9/14.
//

import Foundation
import UIKit

public class TextView: UITextView, FlexboxLayout, UViewChain  {
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        flex.enabled(true)
        flex.markDirty()
    }

    public convenience init(_ text: String?) {
        self.init(frame: .zero)
        self.text = text
    }

    public convenience init(_ attr: NSAttributedString?) {
        self.init(frame: .zero)
        attributedText = attr
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("\(self)")
    }
}

public extension TextView {
    @discardableResult func delegate(_ delegate: UITextViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult func text(_ text: String) -> Self {
        self.text = text
        flex.markDirty()

        return self
    }

    @discardableResult func font(_ font: UIFont?) -> Self {
        self.font = font
        flex.markDirty()

        return self
    }

    @discardableResult func textColor(_ textColor: UIColor?) -> Self {
        self.textColor = textColor
        return self
    }

    @discardableResult func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult func selectedRange(_ selectedRange: NSRange) -> Self {
        self.selectedRange = selectedRange
        return self
    }

    @discardableResult func isEditable(_ isEditable: Bool) -> Self {
        self.isEditable = isEditable
        return self
    }

    @discardableResult func isSelectable(_ isSelectable: Bool) -> Self {
        self.isSelectable = isSelectable
        return self
    }

    @discardableResult func dataDetectorTypes(_ dataDetectorTypes: UIDataDetectorTypes) -> Self {
        self.dataDetectorTypes = dataDetectorTypes
        return self
    }

    @discardableResult func allowsEditingTextAttributes(_ allowsEditingTextAttributes: Bool) -> Self {
        self.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }

    @discardableResult func typingAttributes(_ typingAttributes: [NSAttributedString.Key: Any]) -> Self {
        self.typingAttributes = typingAttributes
        return self
    }

    @discardableResult func inputView(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }

    @discardableResult func inputAccessoryView(_ inputAccessoryView: UIView?) -> Self {
        self.inputAccessoryView = inputAccessoryView
        return self
    }

    @discardableResult func clearsOnInsertion(_ clearsOnInsertion: Bool) -> Self {
        self.clearsOnInsertion = clearsOnInsertion
        return self
    }

    @discardableResult func textContainerInset(_ textContainerInset: UIEdgeInsets) -> Self {
        self.textContainerInset = textContainerInset
        return self
    }

    @discardableResult func linkTextAttributes(_ linkTextAttributes: [NSAttributedString.Key: Any]) -> Self {
        self.linkTextAttributes = linkTextAttributes
        return self
    }

    @available(iOS 13.0, *)
    @discardableResult func usesStandardTextScaling(_ usesStandardTextScaling: Bool) -> Self {
        self.usesStandardTextScaling = usesStandardTextScaling
        return self
    }

    @available(iOS 15.0, *)
    @discardableResult func interactionState(_ interactionState: Any) -> Self {
        self.interactionState = interactionState
        return self
    }

    @discardableResult func autocapitalizationType(_ autocapitalizationType: UITextAutocapitalizationType) -> Self {
        self.autocapitalizationType = autocapitalizationType
        return self
    }

    @discardableResult func autocorrectionType(_ autocorrectionType: UITextAutocorrectionType) -> Self {
        self.autocorrectionType = autocorrectionType
        return self
    }

    @discardableResult func spellCheckingType(_ spellCheckingType: UITextSpellCheckingType) -> Self {
        self.spellCheckingType = spellCheckingType
        return self
    }

    @available(iOS 11.0, *)
    @discardableResult func smartQuotesType(_ smartQuotesType: UITextSmartQuotesType) -> Self {
        self.smartQuotesType = smartQuotesType
        return self
    }

    @available(iOS 11.0, *)
    @discardableResult func smartDashesType(_ smartDashesType: UITextSmartDashesType) -> Self {
        self.smartDashesType = smartDashesType
        return self
    }

    @available(iOS 11.0, *)
    @discardableResult func smartInsertDeleteType(_ smartInsertDeleteType: UITextSmartInsertDeleteType) -> Self {
        self.smartInsertDeleteType = smartInsertDeleteType
        return self
    }

    @discardableResult func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        self.keyboardType = keyboardType
        return self
    }

    @discardableResult func keyboardAppearance(_ keyboardAppearance: UIKeyboardAppearance) -> Self {
        self.keyboardAppearance = keyboardAppearance
        return self
    }

    @discardableResult func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Self {
        self.returnKeyType = returnKeyType
        return self
    }

    @discardableResult func enablesReturnKeyAutomatically(_ enablesReturnKeyAutomatically: Bool) -> Self {
        self.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
        return self
    }

    @discardableResult func isSecureTextEntry(_ isSecureTextEntry: Bool) -> Self {
        self.isSecureTextEntry = isSecureTextEntry
        return self
    }

    @available(iOS 10.0, *)
    @discardableResult func textContentType(_ textContentType: UITextContentType!) -> Self {
        self.textContentType = textContentType
        return self
    }

    @available(iOS 12.0, *)
    @discardableResult func passwordRules(_ passwordRules: UITextInputPasswordRules?) -> Self {
        self.passwordRules = passwordRules
        return self
    }
}
