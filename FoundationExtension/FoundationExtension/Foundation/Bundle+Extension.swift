//
//  Bundle+Extension.swift
//  FoundationExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation


public extension Bundle {
    
    // MARK: Public Properties
    
    var displayName: String? {
        let result = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        return result
    }
    
    var name: String? {
        let result = object(forInfoDictionaryKey: "CFBundleName") as? String
        return result
    }
    
}
