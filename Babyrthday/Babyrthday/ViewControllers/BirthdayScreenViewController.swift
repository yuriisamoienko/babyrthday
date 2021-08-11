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

final class BirthdayScreenViewController: UIViewController, BirthdayScreenViewProtocol {
    
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
    @IBOutlet private weak var shareNewsButton: UIButton!
    
    private lazy var presenter: BirthdayScreenPresenterProtocol = PresenterFactory.shared.createBirthdayScreenPresenter(in: self)
    
    // Flags
    private var didAppearOnce = false
    private let colorStyle: Int = .random(in: 0...2)
    
    // MARK: Overriden functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureBackButton()
        configureNavigationBar()
        presenter.updateView()
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
    
    // MARK: BirthdayScreenViewProtocol:
    
    func setName(_ value: String) {
        titleTopLabel.text = .localize.todaySmnIs(value).uppercased()
    }
    
    func setAgeMonths(_ value: Int) {
        let number = acceptableAgeValue(from: value)
        titleBottomLabel.text = .localize.someMonthOld(number).uppercased()
        setAgeNumber(value)
    }
    
    func setAgeYears(_ value: Int) {
        let number = acceptableAgeValue(from: value)
        titleBottomLabel.text = .localize.someYearOld(number).uppercased()
        setAgeNumber(value)
    }
    
    func setPhoto(_ value: UIImage?) {
        circlePlaceholderImageView.image = value ?? getStyledCirclePlaceholder()
    }
    
    // MARK: Private Functions
    
    private func getStyledCirclePlaceholder() -> UIImage? {
        let result: UIImage?
        switch colorStyle {
        case 0:
            result = .assets.defaultPlaceHolderBlue
        case 1:
            result = .assets.defaultPlaceHolderGreen
        case 2:
            result = .assets.defaultPlaceHolderYellow
        default:
            result = nil
        }
        return result
    }
    
    private func acceptableAgeValue(from value: Int) -> Int {
        let number: Int = max(0, min(value, 99)) // keep between 0 and 99
        return number
    }
    
    private func setAgeNumber(_ value: Int) {
        let number = acceptableAgeValue(from: value)
        
        ageNumberSecondView.showMe()
        if number < 10 {
            ageNumberFirstView.hide()
            ageNumberSecondView.image = .assets.number(number)
        } else {
            ageNumberFirstView.showMe()
            let firstNumber = Int(Double(number)/10)
            let secondNumber = Int(Double(number).truncatingRemainder(dividingBy: 10))
            ageNumberFirstView.image = .assets.number(firstNumber)
            ageNumberSecondView.image = .assets.number(secondNumber)
        }
    }
    
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
        
        backgroundImageView.image = {
            switch self.colorStyle {
            case 0:
                return .assets.iOsBgPelican
            case 1:
                return .assets.iOsBgFox
            case 2:
                return .assets.iOsBgElephant
            default:
                return nil
            }
        }()
        
        if let imageView = cameraImageView,
           let container = imageView.superview
        {
            let angle: CGFloat = .pi/4 // 45 degrees
            container.transform = .init(rotationAngle: angle)
            imageView.transform = .init(rotationAngle: -angle)
            
            imageView.image = {
                switch self.colorStyle {
                case 0:
                    return .assets.cameraIconBlue
                case 1:
                    return .assets.cameraIconGreen
                case 2:
                    return .assets.cameraIconYellow
                default:
                    return nil
                }
            }()
            
            let gestureRecognizer = IBTapGestureRecognizer() { [weak self] _ in
                guard let self = self else { return }
                
                PhotoChooseService(in: self).pickImage { [weak self] images in
                    guard let self = self,
                          let image = images.first
                    else {
                        return
                    }
                    self.presenter.changePhoto(image)
                }
            }
            imageView.addGestureRecognizer(gestureRecognizer)
            imageView.enableUserInteraction()
            container.enableUserInteraction()
        }
        
        circlePlaceholderImageView.image = getStyledCirclePlaceholder()
        
        shareNewsButton.setTitle(.localize.shareTheNews.capitalizingFirstLetter(), for: .normal)
    }
    
    // Targets
    
    @IBAction
    private func onShareButtonTapped(_ sender: Any) {
        let viewsToExcludeFromSnapshot = [shareNewsButton, cameraImageView]
        viewsToExcludeFromSnapshot.forEach { $0?.hide() } // The shared image should not include share button and camera icon
        let snapshot = self.view.takeSnapshot()
        
        // resture UI
        viewsToExcludeFromSnapshot.forEach { $0?.showMe() }
        
        guard let screenshot = snapshot else { return }
        // next is UIKit code so it's not moved to presenter
        let activityViewController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // fixes crash on Ipad
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
