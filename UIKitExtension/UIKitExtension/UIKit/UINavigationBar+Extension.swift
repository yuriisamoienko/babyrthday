//
//  UINavigationBar+Extension.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 11.08.2021.
//

import UIKit

public extension UINavigationBar {
    
    // MARK: Public Functions
    
    static var statusBarHeight: CGFloat {
        let result = UIApplication.shared.statusBarFrame.height
        return result
    }
}
