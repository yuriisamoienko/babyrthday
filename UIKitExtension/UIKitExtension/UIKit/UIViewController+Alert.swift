//
//  UIViewController+Alert.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import Foundation
import FoundationExtension
import UIKit

public extension UIViewController {
    class UIAlertDisplayer {
        private let viewController: UIViewController
        
        init(viewController: UIViewController) {
            self.viewController = viewController
        }
    }
    
    var alert: UIAlertDisplayer {
        UIAlertDisplayer(viewController: self)
    }
}

public extension UIViewController.UIAlertDisplayer {
    
    // MARK: Public Functions
    
    func showErrorAlert(message: String, closeCallback: (() -> Void)? = nil) {
        showAlert(
            title: .localize.error.capitalizingFirstLetter(),
            message: message,
            closeCallback: closeCallback
        )
    }
    
    func showAlert(title: String? = nil, message: String? = nil, closeCallback: (() -> Void)? = nil) {
        guard title != nil || message != nil else { return }
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default) { (_) in
            guard let callback = closeCallback else { return }
            callback()
        }
        alertController.addAction(okAction)

        viewController.present(alertController, animated: false)
    }
    
}
