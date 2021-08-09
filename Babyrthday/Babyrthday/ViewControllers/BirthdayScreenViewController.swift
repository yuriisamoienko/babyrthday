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
    
    // IB
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var circlePlaceholderImageView: UIImageView!
    @IBOutlet private weak var ageNumberFirstView: UIImageView!
    @IBOutlet private weak var ageNumberSecondView: UIImageView!
    @IBOutlet private weak var titleTopLabel: UILabel!
    @IBOutlet private weak var titleBottomLabel: UILabel!
    @IBOutlet private weak var cameraImageView: UIImageView!
    @IBOutlet private weak var circlePlaceholderContainerView: UIView!
    @IBOutlet private weak var circlePlaceholderView: UIView!
    
    // Flags
    private var didAppearOnce = false
    
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
        didAppearOnce = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        restoreNavigationBarAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if didAppearOnce == false {
            circlePlaceholderView.roundedCorners = true // do it here to fix jumping of the rounded border
        }
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
        
        if true,
           let imageView = cameraImageView,
           let container = imageView.superview
        {
            let angle: CGFloat = .pi/4 // 45 degrees
            container.transform = .init(rotationAngle: angle)
            imageView.transform = .init(rotationAngle: -angle)
        }
    }
    
    // Targets
    
    @IBAction func onShareButtonTapped(_ sender: Any) {
    }
    
    
}
