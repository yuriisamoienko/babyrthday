//
//  String+Extension.swift
//  FoundationExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation

/*
 General unification of localization.
 
 example:
 let text: String =  .localize.error
 */

public protocol Localizable {
    var localized: String { get }
}

public extension String {
    
    // MARK: Namespaces
    
    class Localizations {
        public var error: String {
            "k_error".localized
        }
    }
    
    // MARK: Public Properties
    
    static var localize = Localizations()
    
    // MARK: Public Functions
    
    static func localeCode() -> String {
        var localeIdentifier = UserDefaults.standard.value(forKey: "AppLanguageUI") as? String ?? Locale.preferredLanguages.first ?? Locale.current.languageCode ?? ""
        localeIdentifier = localeIdentifier.substring(to: 2)
        if localeIdentifier == "auto" {
            localeIdentifier = ""
        }
        if localeIdentifier == "" {
            let supportedLangs = ["ru", "en"]
            if let obj = UserDefaults.standard.value(forKey: "AppleLanguages") {
                if let appleLanguages = obj as? [String] {
                    for lang in appleLanguages {
                        let langCode = String(lang.prefix(2))
                        if supportedLangs.contains(langCode) {
                            localeIdentifier = langCode
                            break
                        }
                    }
                }
            }
        }
        if localeIdentifier == "" {
            localeIdentifier = "en"
        }
        return localeIdentifier
    }
    
}

extension String: Localizable {
    
    public var localized: String {
        let bundle = Bundle.main
        let localeIdentifier = String.localeCode()
        let result = NSLocalizedString(self, tableName: "Localization_\(localeIdentifier)", bundle: bundle, comment: "")
        if result == "" {
            return self
        }
        return result
    }
    
}

public extension String.Localizations {
    
    var no: String {
        "k_no".localized
    }
    var yes: String {
        "k_yes".localized
    }
}
