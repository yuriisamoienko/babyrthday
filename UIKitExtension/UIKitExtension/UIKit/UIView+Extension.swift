//
//  UIView+Extension.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit

public extension UIView {
    
    // MARK: Public Properties
    
    var frameWidth: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newValue, height: frame.size.height)
        }
    }
    
    var frameSize: CGSize {
        get {
            return frame.size
        }
        set {
            frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newValue.width, height: newValue.height)
        }
    }
    
    var frameCenter: CGPoint {
        set {
            frame.center = newValue
        }
        get {
            let result = frame.center
            return result
        }
    }
    
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
    
    func takeSnapshot() -> UIImage? {
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: IBInspectable
    
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
    
    @IBInspectable var roundedCorners: Bool {
        set {
            var value: CGFloat = 0
            if newValue == true {
                value = frameWidth/2
            }
            cornerRadius = value
        }
        get {
            return false
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
