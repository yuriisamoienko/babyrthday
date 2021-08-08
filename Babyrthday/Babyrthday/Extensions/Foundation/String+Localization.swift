//
//  String+Localization.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation
import FoundationExtension

/*
 Contains localization keys list
 
 example:
 let text: String = .localize.map.capitalized
 */

extension String.Localizations {
    
    // MARK: Public Properties
    
    var enterBabyName: String {
        "k_enter_baby_name".localized
    }
    var showBirthdayScreen: String {
        "k_show_birthday_screen".localized
    }
    var cameraNotFound: String {
        "k_camera_not_found".localized
    }
    var cancel: String {
        "k_cancel".localized
    }
    var gallery: String {
        "k_gallery".localized
    }
    var camera: String {
        "k_camera".localized
    }
    var chooseImage: String {
        "k_choose_image".localized
    }

}

