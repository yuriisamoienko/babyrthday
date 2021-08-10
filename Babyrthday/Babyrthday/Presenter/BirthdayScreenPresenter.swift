//
//  BirthdayScreenPresenter.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 10.08.2021.
//

import UIKit
import UIKitExtension
import FoundationExtension


protocol BirthdayScreenPresenterProtocol {
    func updateView()
    
}

protocol BirthdayScreenViewProtocol: AnyObject {
    
    func setName(_ value: String)
    func setAgeMonths(_ value: Int)
    func setAgeYears(_ value: Int)
    func setPhoto(_ value: UIImage?)
    
}

final class BirthdayScreenPresenter: NSObject, BirthdayScreenPresenterProtocol {
    
    // MARK: Private Properties
    
    private weak var view: BirthdayScreenViewProtocol!
    private let userDefaults = UserDefaults.standard
    
    // MARK: Public Functions
    
    convenience init(view: BirthdayScreenViewProtocol) {
        self.init()
        self.view = view
    }
    
    // MARK: DetailsPresenterProtocol
    
    func updateView() {
        if let name = userDefaults.string(forKey: UserDefaultKeys.personName.rawValue) {
            view.setName(name)
        }
        if let timeStamp = userDefaults.value(forKey: UserDefaultKeys.personBirthday.rawValue) as? TimeInterval {
            let birthday = Date(timeIntervalSince1970: timeStamp)
            let months = Date().months(from: birthday)
            if months < 12 {
                view.setAgeMonths(months)
            } else {
                let years = Int(months/12)
                view.setAgeYears(years)
            }
        }
        if let photoData = userDefaults.value(forKey: UserDefaultKeys.personPhoto.rawValue) as? Data,
           let photo = UIImage(data: photoData)
        {
            view.setPhoto(photo)
        }
    }

}
