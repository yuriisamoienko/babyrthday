//
//  UIView+Extension.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit

public extension UIView {
    
    // MARK: Public Functions
    
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
    
}
