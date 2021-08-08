//
//  Array+Extension.swift
//  FoundationExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation

public extension Array {
    
    // MARK: Public Properties
    
    var isNotEmpty: Bool {
        get {
            return isEmpty == false
        }
    }

}
