//
//  PresenterFactory.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 11.08.2021.
//

import Foundation

final class PresenterFactory {
    
    // MARK: Public Properties
    
    static let shared = PresenterFactory()
    
    // MARK: Public Functions
    
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
