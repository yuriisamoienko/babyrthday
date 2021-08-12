//
//  PresenterFactory.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 11.08.2021.
//

import Foundation

protocol PresenterFactoryProtocol {
    
    func createDetailsPresenter(in view: DetailsPresenterViewProtocol) -> DetailsPresenterProtocol
    func createBirthdayScreenPresenter(in view: BirthdayScreenViewProtocol) -> BirthdayScreenPresenterProtocol
    
}

final class PresenterFactory: PresenterFactoryProtocol {
    
    // MARK: Public Properties
    
    static let shared: PresenterFactoryProtocol = PresenterFactory() // TODO @Inject
    
    // MARK: PresenterFactoryProtocol
    
    func createDetailsPresenter(in view: DetailsPresenterViewProtocol) -> DetailsPresenterProtocol {
        let result = DetailsPresenter(view: view)
        return result
    }
    
    func createBirthdayScreenPresenter(in view: BirthdayScreenViewProtocol) -> BirthdayScreenPresenterProtocol {
        let result = BirthdayScreenPresenter(view: view)
        return result
    }
    
    // MARK: Private Functions
    
    private init() {}
}
