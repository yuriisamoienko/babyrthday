//
//  UIEdgeInsets+Extension.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit

public extension UIEdgeInsets {
    
    // MARK: Public Functions
    
    static func make(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> Self  {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
}
