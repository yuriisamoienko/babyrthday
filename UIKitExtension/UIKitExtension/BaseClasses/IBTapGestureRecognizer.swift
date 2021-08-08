//
//  IBTapGestureRecognizer.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit
import FoundationExtension

open class IBTapGestureRecognizer: UITapGestureRecognizer {
    
    // MARK: Private Properties
    
    private var callback: ((UITapGestureRecognizer) -> Void)!
    
    convenience public init(callback: @escaping (UITapGestureRecognizer) -> Void) {
        self.init()
        self.callback = callback
        addTarget(self, action: #selector(Self.invoke(sender:)))
    }
    
    @objc func invoke(sender: UITapGestureRecognizer) {
        callback(sender)
    }
}

