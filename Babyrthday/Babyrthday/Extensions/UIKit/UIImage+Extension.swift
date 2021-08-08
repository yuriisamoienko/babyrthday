//
//  UIImage+Extension.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit

extension UIImage {
    
    class Assets {
        var photoPlaceholder: UIImage? {
            UIImage(named: "photoPlaceholder")
        }
    }
    
    static var assets: Assets {
        Assets()
    }
    
}
