//
//  CGRect+Extension.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 11.08.2021.
//

import UIKit

public extension CGRect {
    
    // MARK: Public Properties
    
    var centerX: CGFloat {
        set {
            x = newValue - width/2
        }
        get {
            let result = x + width/2
            return result
        }
    }
    
    var centerY: CGFloat {
        set {
            y = newValue - height/2
        }
        get {
            let result = y + height/2
            return result
        }
    }
    
    var center: CGPoint {
        set {
            centerX = newValue.x
            centerY = newValue.y
        }
        get {
            let result = CGPoint(x: centerX, y: centerY)
            return result
        }
    }

}

internal extension CGRect {
    
    var x: CGFloat {
        get {
            return origin.x
        }
        set {
            origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            return origin.y
        }
        set {
            origin.y = newValue
        }
    }

}
