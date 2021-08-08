//
//  BirthdayScreenViewController.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit

/*
 The birthday screen has 3 visual options. One should be chosen randomly every time you enter the screen.
 Birthdays are shown by months until 1 year and then in years. The correct age should be displayed according to the baby's birthday.
 If the name is too long for one line the title will occupy two lines (see screen design).
 Pushing the close button (top left corner) will return to the previous screen.
 */

final class BirthdayScreenViewController: UIViewController {

    // MARK: Overriden functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Private Functions
    
    private func configureBackButton() {
        // configure custom back button
        let backBtn = UIBarButtonItem(
            image: .assets.arrowBackBlue,
            style: .plain,
            target: navigationController,
            action: #selector(UINavigationController.popViewController(animated:))
        )
        navigationItem.leftBarButtonItem = backBtn
    }
    
}
