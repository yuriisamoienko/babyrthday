//
//  DetailsPresenter.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit
import UIKitExtension
import FoundationExtension

protocol DetailsPresenterProtocol {
    func updateView()
    func setPhoto(_ value: UIImage?)
    
    func savePersonName(_ value: String)
    func saveBirthdayDate(_ value: Date)
    func savePhoto(_ value: UIImage?)
}

protocol DetailsPresenterViewProtocol: AnyObject {
    
    func setPersonName(_ value: String)
    func setBirthdayDate(_ value: Date)
    func setPhoto(_ value: UIImage?)
    
}

final class DetailsPresenter: NSObject, DetailsPresenterProtocol {
    
    enum UserDefaultKeys: String {
        case personName
        case personBirthday
        case personPhoto
    }

    // MARK: Private Properties
    
    private weak var view: DetailsPresenterViewProtocol!
    private let userDefaults = UserDefaults.standard
    
    // MARK: Public Functions
    
    convenience init(view: DetailsPresenterViewProtocol) {
        self.init()
        self.view = view
    }
    
    // MARK: DetailsPresenterProtocol
    
    func updateView() {
        if let name = userDefaults.string(forKey: UserDefaultKeys.personName.rawValue) {
            view.setPersonName(name)
        }
        if let timeStamp = userDefaults.value(forKey: UserDefaultKeys.personBirthday.rawValue) as? TimeInterval {
            let date = Date(timeIntervalSince1970: timeStamp)
            view.setBirthdayDate(date)
        }
        if let photoData = userDefaults.value(forKey: UserDefaultKeys.personPhoto.rawValue) as? Data,
           let photo = UIImage(data: photoData)
        {
            view.setPhoto(photo)
        }
    }
    
    func setPhoto(_ value: UIImage?) {
        view.setPhoto(value)
    }
    
    func savePersonName(_ value: String) {
        setUserDefaultsValue(value, forKey: .personName)
    }
    
    func saveBirthdayDate(_ value: Date) {
        setUserDefaultsValue(value.timeIntervalSince1970, forKey: .personBirthday)
    }
    
    func savePhoto(_ value: UIImage?) {
        guard let value = value else {
            setUserDefaultsValue(nil, forKey: .personPhoto)
            return
        }
        setUserDefaultsValue(value.jpegData(compressionQuality: 1.0), forKey: .personPhoto)
    }
    
    // MARK: Private Functions
    
    func setUserDefaultsValue(_ value: Any?, forKey key: UserDefaultKeys) {
        userDefaults.setValue(value, forKey: key.rawValue)
        userDefaults.synchronize()
    }
}
