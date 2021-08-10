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
        var arrowBackBlue: UIImage? {
            UIImage(named: "arrowBackBlue")
        }
        var defaultPlaceHolderBlue: UIImage? {
            UIImage(named: "defaultPlaceHolderBlue")
        }
        var defaultPlaceHolderGreen: UIImage? {
            UIImage(named: "defaultPlaceHolderGreen")
        }
        var defaultPlaceHolderYellow: UIImage? {
            UIImage(named: "defaultPlaceHolderYellow")
        }
        
        var cameraIconBlue: UIImage? {
            UIImage(named: "cameraIconBlue")
        }
        var cameraIconGreen: UIImage? {
            UIImage(named: "cameraIconGreen")
        }
        var cameraIconYellow: UIImage? {
            UIImage(named: "cameraIconYellow")
        }
        
        var iOsBgElephant: UIImage? {
            UIImage(named: "iOsBgElephant")
        }
        var iOsBgFox: UIImage? {
            UIImage(named: "iOsBgFox")
        }
        var iOsBgPelican: UIImage? {
            UIImage(named: "iOsBgPelican")
        }
        
        func number(_ value: Int) -> UIImage? {
            let result = UIImage(named: "number_\(value)")
            return result
        }
    }
    
    static var assets: Assets {
        Assets()
    }
    
}
