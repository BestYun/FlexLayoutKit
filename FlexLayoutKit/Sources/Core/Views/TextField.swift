//
//  TextField.swift
//  FlexLayoutKit
//
//  Created by yun on 2023/9/11.
//

import Foundation
import UIKit
//TextInput
public class TextField: UITextField, FlexboxLayout, UViewChain  {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        flex.enabled(true)
        flex.markDirty()
    }

    public convenience init(_ text: String?) {
        self.init(frame: .zero)
        self.text = text
    }

    public convenience init(placeholder: String?, text: String? = nil) {
        self.init(frame: .zero)
        self.text = text
        self.placeholder(placeholder)
    }

    public convenience init(_ attr: NSAttributedString?) {
        self.init(frame: .zero)
        attributedText = attr
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension TextField {
    @discardableResult func text(_ text: String?) -> Self {
        self.text = text
        markDirty()
        return self
    }

    @discardableResult func attributedText(_ text: NSAttributedString?) -> Self {
        attributedText = text
        markDirty()
        return self
    }

    @discardableResult func textColor(_ textColor: UIColor?) -> Self {
        self.textColor = textColor
        return self
    }

    @discardableResult func font(_ font: UIFont?) -> Self {
        self.font = font
        markDirty()
        return self
    }

    @discardableResult func textAlignment(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    @discardableResult func borderStyle(_ borderStyle: UITextField.BorderStyle) -> Self {
        self.borderStyle = borderStyle
        return self
    }

    @discardableResult func defaultTextAttributes(_ defaultTextAttributes: [NSAttributedString.Key: Any]) -> Self {
        self.defaultTextAttributes = defaultTextAttributes
        return self
    }

    @discardableResult func placeholder(_ placeholder: String?) -> Self {
        self.placeholder = placeholder
        return self
    }

    @discardableResult func attributedPlaceholder(_ attributedPlaceholder: NSAttributedString?) -> Self {
        self.attributedPlaceholder = attributedPlaceholder
        return self
    }

    @discardableResult func placeholderColor(_ placeholderColor: UIColor) -> Self {
        if let attr = attributedPlaceholder {
            let newAttr = NSMutableAttributedString(attributedString: attr)
            let placeholderText = newAttr.string
            let range = NSRange(location: 0, length: placeholderText.count)
            newAttr.addAttributes([NSAttributedString.Key.foregroundColor: placeholderColor], range: range)
            attributedPlaceholder = newAttr
        } else {
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        }

        return self
    }

    @discardableResult func placeholderFont(_ placeholderFont: UIFont) -> Self {
        if let attr = attributedPlaceholder {
            let newAttr = NSMutableAttributedString(attributedString: attr)
            let placeholderText = newAttr.string
            let range = NSRange(location: 0, length: placeholderText.count)
            newAttr.addAttributes([NSAttributedString.Key.font: placeholderFont], range: range)
            attributedPlaceholder = newAttr
        } else {
            attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.font: placeholderFont])
        }

        return self
    }

    @discardableResult func clearsOnBeginEditing(_ clearsOnBeginEditing: Bool) -> Self {
        self.clearsOnBeginEditing = clearsOnBeginEditing
        return self
    }

    @discardableResult func adjustsFontSizeToFitWidth(_ adjustsFontSizeToFitWidth: Bool) -> Self {
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        return self
    }

    @discardableResult func minimumFontSize(_ minimumFontSize: CGFloat) -> Self {
        self.minimumFontSize = minimumFontSize
        return self
    }

    @discardableResult func delegate(_ delegate: UITextFieldDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    @discardableResult func background(_ background: UIImage?) -> Self {
        self.background = background
        return self
    }

    @discardableResult func disabledBackground(_ disabledBackground: UIImage?) -> Self {
        self.disabledBackground = disabledBackground
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

    @discardableResult func clearButtonMode(_ clearButtonMode: UITextField.ViewMode) -> Self {
        self.clearButtonMode = clearButtonMode
        return self
    }

    @discardableResult func leftView(_ leftView: UIView?) -> Self {
        self.leftView = leftView
        return self
    }

    @discardableResult func leftViewMode(_ leftViewMode: UITextField.ViewMode) -> Self {
        self.leftViewMode = leftViewMode
        return self
    }

    @discardableResult func rightView(_ rightView: UIView?) -> Self {
        self.rightView = rightView
        return self
    }

    @discardableResult func rightViewMode(_ rightViewMode: UITextField.ViewMode) -> Self {
        self.rightViewMode = rightViewMode
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

