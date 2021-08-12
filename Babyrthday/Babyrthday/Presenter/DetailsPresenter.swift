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

    // MARK: Private Properties
    
    private weak var view: DetailsPresenterViewProtocol!
    private var repository: UserProfileRepositoryProtocol = UserProfileRepository.shared
    
    // MARK: Public Functions
    
    convenience init(view: DetailsPresenterViewProtocol) {
        self.init()
        self.view = view
    }
    
    // MARK: DetailsPresenterProtocol
    
    func updateView() {
        if let name = repository.getPersonName() { //} userDefaults.string(forKey: UserDefaultKeys.personName.rawValue) {
            view.setPersonName(name)
        }
        if let date = repository.getBirthdayDate() { //userDefaults.value(forKey: UserDefaultKeys.personBirthday.rawValue) as? TimeInterval {
//            let date = Date(timeIntervalSince1970: timeStamp)
            view.setBirthdayDate(date)
        }
        if let photo = repository.getPhoto() // userDefaults.value(forKey: UserDefaultKeys.personPhoto.rawValue) as? Data,
           //let photo = UIImage(data: photoData)
        {
            view.setPhoto(photo)
        }
    }
    
    func setPhoto(_ value: UIImage?) {
        view.setPhoto(value)
    }
    
    func savePersonName(_ value: String) {
        repository.setPersonName(value)
    }
    
    func saveBirthdayDate(_ value: Date) {
        repository.setBirthdayDate(value)
    }
    
    func savePhoto(_ value: UIImage?) {
        repository.setPhoto(value)
    }
    
    // MARK: Private Functions
    
}

