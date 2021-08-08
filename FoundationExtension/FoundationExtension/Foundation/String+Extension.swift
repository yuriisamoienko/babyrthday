//
//  String+Extension.swift
//  FoundationExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation

public extension String {
    
    // MARK: Public Functions

    func substring(to index: Int) -> Self {
        let result = (self as NSString).substring(to: index)
        return result
    }

}
