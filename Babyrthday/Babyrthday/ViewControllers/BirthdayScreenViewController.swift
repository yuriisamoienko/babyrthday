//
//  BirthdayScreenViewController.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit
import UIKitExtension

/*
 The birthday screen has 3 visual options. One should be chosen randomly every time you enter the screen.
 Birthdays are shown by months until 1 year and then in years. The correct age should be displayed according to the baby's birthday.
 If the name is too long for one line the title will occupy two lines (see screen design).
 Pushing the close button (top left corner) will return to the previous screen.
 */

final class BirthdayScreenViewController: UIViewController {
    
    // MARK: Private Properties
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var circlePlaceholderImageView: UIImageView!
    @IBOutlet private weak var ageNumberFirstView: UIImageView!
    @IBOutlet private weak var ageNumberSecondView: UIImageView!
    @IBOutlet private weak var titleTopLabel: UILabel!
    @IBOutlet private weak var titleBottomLabel: UILabel!
    
    // MARK: Overriden functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureBackButton()
        configureNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        restoreNavigationBarAppearance()
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
    
    private func configureNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    private func restoreNavigationBarAppearance() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.shadowImage = nil
    }
    
    private func configureLayout() {
        ageNumberSecondView.hide()
    }
    
    // Targets
    
    @IBAction func onShareButtonTapped(_ sender: Any) {
    }
    
    
}
