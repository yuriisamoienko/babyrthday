//
//  UIView+Extension.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit

public extension UIView {
    
    // MARK: Public Functions
    
    func hideKeyboard() {
        endEditing(true)
    }
    
    func disableUserInteraction() {
        isUserInteractionEnabled = false
    }

    func enableUserInteraction() {
        isUserInteractionEnabled = true
    }
    
    func hide()  {
        isHidden = true
    }

    func showMe() {
        isHidden = false
    }
    
    // MARK: - IBInspectable
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            if newValue != 0 {
                clipsToBounds = true // without it cornerRadius doens't work
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
