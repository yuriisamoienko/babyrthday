//
//  UIViewController+Extension.swift
//  UIKitExtension
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import FoundationExtension
import UIKit

public extension UIViewController {
    
    // MARK: Public Functions
    
    static func createWithNib() -> Self {
        return createWithNib(bundle: nil)
    }
    
    static func createWithNib(bundle: Bundle?) -> Self {
        let name = String(describing: Self.self)
        return createWith(nib: name, identifier: name, bundle: bundle)
    }
    
    static func createWith(nib: String, identifier: String, bundle: Bundle?) -> Self {
        let board = UIStoryboard.init(name: nib, bundle: bundle)
        let result = board.instantiateViewController(withIdentifier: identifier) as! Self
        return result
    }
    
    static func createWithXib(bundle: Bundle? = nil) -> Self {
        let type = Self.self
        let className = String(describing: type)
        let result = Self.init(nibName: className, bundle: bundle)
        return result
    }
    
    func present(viewController: UIViewController?, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let viewController = viewController else { return }
        if self.presentedViewController == viewController {
            return
        }
        DispatchQueue.main.async { [self, animated, completion] in
            self.present(viewController, animated: animated, completion: completion)
        }
    }

}
