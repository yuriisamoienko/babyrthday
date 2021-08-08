//
//  ViewController.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Private Properties
    
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: Overriden functions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = Bundle.main.displayName ?? Bundle.main.name
        self.nameTextField.placeholder = .localize.enterBabyName
        
        if let picker = self.birthdayDatePicker {
            picker.backgroundColor = .appThemeBackground
        }
        
        if let btn = self.nextButton {
            btn.setTitle(.localize.showBirthdayScreen.capitalized, for: .normal)
            btn.backgroundColor = .appThemeBackground
//            btn.titleEdgeInsets = .make(left: 10, right: 10)
        }
        
    }

    // MARK: Private Functions

}

fileprivate extension Bundle {
    
    var displayName: String? {
        let result = object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        return result
    }
    
    var name: String? {
        let result = object(forInfoDictionaryKey: "CFBundleName") as? String
        return result
    }
    
}
