//
//  UserProfileRepository.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 12.08.2021.
//

import Foundation
import UIKit

protocol UserProfileRepositoryProtocol {
   
    func setPersonName(_ value: String)
    func setBirthdayDate(_ value: Date)
    func setPhoto(_ value: UIImage?)
    
    func getPersonName() -> String?
    func getBirthdayDate() -> Date?
    func getPhoto() -> UIImage?
}

final class UserProfileRepository: UserProfileRepositoryProtocol {
    
    // MARK: Private Properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: Public Properties
    
    static let shared: UserProfileRepositoryProtocol = UserProfileRepository() // TODO @Inject
    
    // MARK: UserProfileRepositoryProtocol
    
    func setPersonName(_ value: String) {
        setUserDefaultsValue(value, forKey: .personName)
    }
    
    func setBirthdayDate(_ value: Date) {
        setUserDefaultsValue(value.timeIntervalSince1970, forKey: .personBirthday)
    }
    
    func setPhoto(_ value: UIImage?) {
        setUserDefaultsValue(value?.jpegData(compressionQuality: 1.0), forKey: .personPhoto)
    }
    
    func getPersonName() -> String? {
        let result = userDefaults.string(forKey: UserDefaultKeys.personName.rawValue)
        return result
    }
    
    func getBirthdayDate() -> Date? {
        var result: Date? = nil
        if let timeStamp = userDefaults.value(forKey: UserDefaultKeys.personBirthday.rawValue) as? TimeInterval {
            result = Date(timeIntervalSince1970: timeStamp)
        }
        return result
    }
    
    func getPhoto() -> UIImage? {
        var result: UIImage? = nil
        if let photoData = userDefaults.value(forKey: UserDefaultKeys.personPhoto.rawValue) as? Data {
            result = UIImage(data: photoData)
        }
        return result
    }
    
    // MARK: Private Functions
    
    private init() {}
    
    func setUserDefaultsValue(_ value: Any?, forKey key: UserDefaultKeys) {
        userDefaults.setValue(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }
}

enum UserDefaultKeys: String {
    case personName
    case personBirthday
    case personPhoto
}
