//
//  ViewController.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import FoundationExtension
import UIKit
import UIKitExtension

final class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Private Properties
    
    @IBOutlet weak var birthdayDatePicker: IBDatePicker!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
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

    // MARK: Private Functions
    
    private func configureUI() {
        self.title = Bundle.main.displayName ?? Bundle.main.name
        
        if let textField = self.nameTextField {
            textField.placeholder = .localize.enterBabyName
            textField.delegate = self
        }
        
        if let picker = self.birthdayDatePicker {
            picker.tintColor = .appThemeBackground
            picker.borderColor = .appThemeBackground
            let currentDate = Date()
            picker.date = currentDate
            picker.maximumDate = currentDate
            picker.onValueChandedCallback = { [weak self] _ in
                self?.isBirthdayDateSet = true
            }
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
    
    func updateNextButtonEnabled() {
        updateNextButtonEnabled(with: nameTextField.text)
    }
    
    func updateNextButtonEnabled(with text: String?) {
        guard let btn = self.nextButton else { return }
        let enabled = isBirthdayDateSet && (text?.isNotEmpty ?? false)
        btn.isEnabled = enabled
        btn.backgroundColor = enabled ? .appThemeBackground : .appThemeBackground.withAlphaComponent(0.3)
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
}
