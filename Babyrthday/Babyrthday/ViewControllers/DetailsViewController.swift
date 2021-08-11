//
//  ViewController.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import FoundationExtension
import UIKit
import UIKitExtension

/*
 Users should be able to open the app and see the details screen.
 Screen includes the following elements:
 - App title
 - Name
 - Birthday
 - Picture
 - “Show birthday screen” button (disabled while name & birthday are empty)
 */

final class DetailsViewController: UIViewController, UITextFieldDelegate, DetailsPresenterViewProtocol {
    
    // MARK: Private Properties
    
    @IBOutlet private weak var birthdayDatePicker: IBDatePicker!
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var nextButton: UIButton!
    
    private lazy var presenter: DetailsPresenterProtocol = PresenterFactory.shared.createDetailsPresenter(in: self)
    private var saveNameDelayedWork: DispatchWorkItem?
    
    // Flags
    private var isBirthdayDateSet = false {
        didSet {
            self.updateNextButtonEnabled()
        }
    }
    
    // MARK: Overriden functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.nameTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            self.updateNextButtonEnabled(with: updatedText)
            
            // call save name if user didn't tap anything for some time, to save if user wil close app after without tap Done button
            self.saveNameDelayedWork?.cancel()
            self.saveNameDelayedWork = debounceTask(delay: 1, closure: { [weak self] in
                self?.saveEnteredName()
            })
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameTextField {
           self.view.hideKeyboard()
           return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameTextField {
            saveEnteredName()
        }
    }
    
    // MARK: DetailsPresenterViewProtocol
    
    func setPersonName(_ value: String) {
        nameTextField.text = value
        updateNextButtonEnabled()
    }
    
    func setBirthdayDate(_ value: Date) {
        birthdayDatePicker.date = value
        isBirthdayDateSet = true
        updateNextButtonEnabled()
    }
    
    func setPhoto(_ value: UIImage?) {
        photoImageView.image = value ?? .assets.photoPlaceholder
    }
    
    // MARK: Private Functions
    
    private func saveEnteredName() {
        presenter.savePersonName(nameTextField.text ?? "")
    }
    
    private func configureUI() {
        self.title = Bundle.main.displayName ?? Bundle.main.name
        
        if let textField = self.nameTextField {
            textField.placeholder = .localize.enterBabyName
            textField.delegate = self
            textField.borderColor = .appThemeBackground
        }
        
        if let picker = self.birthdayDatePicker {
            picker.tintColor = .appThemeBackground
            picker.borderColor = .appThemeBackground
            let currentDate = Date()
            picker.date = currentDate
            picker.maximumDate = currentDate
            picker.onValueChandedCallback = { [weak self] picker in
                guard let self = self else { return }
                self.isBirthdayDateSet = true
                self.presenter.saveBirthdayDate(picker.date)
            }
        }
        
        if let imageView = self.photoImageView {
            let gestureRecognizer = IBTapGestureRecognizer() { [weak self] _ in
                guard let self = self else { return }
                
                PhotoChooseService(in: self).pickImage { [weak self] images in
                        guard let self = self,
                              let image = images.first
                        else {
                            return
                        }
                        self.presenter.setPhoto(image)
                        self.presenter.savePhoto(image)
                    }
            }
            imageView.addGestureRecognizer(gestureRecognizer)
            imageView.enableUserInteraction()
        }
        
        if let btn = self.nextButton {
            btn.setTitle(.localize.showBirthdayScreen.capitalized, for: .normal)
        }
        
        if let view = self.view {
            /* Need hidekeyboard when tap somewhere */
            let gestureRecognizer = IBTapGestureRecognizer() { [weak self] _ in
                self?.view.hideKeyboard()
            }
            view.addGestureRecognizer(gestureRecognizer)
            /* End hide keyboard*/
        }
        
        self.updateNextButtonEnabled()
    }
    
    private func updateNextButtonEnabled() {
        updateNextButtonEnabled(with: nameTextField.text)
    }
    
    private func updateNextButtonEnabled(with text: String?) {
        guard let btn = self.nextButton else { return }
        let enabled = isBirthdayDateSet && (text?.isNotEmpty ?? false)
        btn.isEnabled = enabled
        btn.backgroundColor = enabled ? .appThemeBackground : .appThemeBackground.withAlphaComponent(0.3)
    }
    
    private func showBirthdayScreen() {
        let vc = BirthdayScreenViewController.createWithXib()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Targets
    
    @IBAction func onNextButtonTapped(_ sender: Any) {
        showBirthdayScreen()
    }
}
