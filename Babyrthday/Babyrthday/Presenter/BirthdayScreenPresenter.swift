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
    func changePhoto(_ value: UIImage?)
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
    private var repository: UserProfileRepositoryProtocol = UserProfileRepository.shared
    
    // MARK: Public Functions
    
    convenience init(view: BirthdayScreenViewProtocol) {
        self.init()
        self.view = view
    }
    
    // MARK: DetailsPresenterProtocol
    
    func updateView() {
        if let name = repository.getPersonName() {
            view.setName(name)
        }
 
        if let birthday = repository.getBirthdayDate() {
            let months = Date().months(from: birthday)
            if months < 12 {
                view.setAgeMonths(months)
            } else {
                let years = Int(months/12)
                view.setAgeYears(years)
            }
        }
        if let photo = repository.getPhoto() {
            view.setPhoto(photo)
        }
    }
    
    func changePhoto(_ value: UIImage?) {
        view.setPhoto(value)
    
        repository.setPhoto(value)
    }

}
