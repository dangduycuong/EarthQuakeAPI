//
//  PasswordTextField.swift
//  EarthQuakeAPI
//
//  Created by cuongdd on 20/3/25.
//  Copyright © 2025 duycuong. All rights reserved.
//

import UIKit

class PasswordTextField: UITextField {
    
    private let visibilityButton = UIButton(type: .custom)
    private var isSecureTextEntryEnabled: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        isSecureTextEntry = isSecureTextEntryEnabled
        configureVisibilityButton()
        updateVisibilityButtonImage()
    }
    
    private func configureVisibilityButton() {
        visibilityButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        rightView = visibilityButton
        rightViewMode = .always
        visibilityButton.frame = CGRect(x: 0, y: 0, width: 30, height: frame.size.height) // Adjust width as needed
        visibilityButton.contentMode = .center
    }
    
    private func updateVisibilityButtonImage() {
        let imageName = isSecureTextEntryEnabled ? "eye.slash.fill" : "eye.fill"
        if let eyeImage = UIImage(systemName: imageName) {
            visibilityButton.setImage(eyeImage, for: .normal)
        }
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntryEnabled.toggle()
        isSecureTextEntry = isSecureTextEntryEnabled
        // Prevent cursor from jumping to the end
        if let selectedRange = selectedTextRange {
            replace(selectedRange, withText: text ?? "")
        }
        updateVisibilityButtonImage()
    }
    
    // Override textRect(forBounds:) and editingRect(forBounds:) to adjust
    // the text field's text area to accommodate the visibility button.
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.size.width -= 30 // Adjust based on button width and padding
        return rect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect.size.width -= 30 // Adjust based on button width and padding
        return rect
    }
    
    // Optional: Add placeholder customization if needed
    override var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    private func updatePlaceholder() {
        if let placeholderText = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray] // Customize color
            )
        }
    }
}
