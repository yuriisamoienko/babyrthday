//
//  AppDelegate.swift
//  Babyrthday
//
//  Created by Yurii Samoienko on 08.08.2021.
//

import UIKit
import UIKitExtension

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Public Properties
    
    var window: UIWindow?
    
    // MARK: Public Functions

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureGlobalAppStyle()
        configureWindow()
        
        return true
    }
    
    // MARK: Private Functions
    
    private func configureWindow() {
        // Main.storyboard is autoloaded
    }
    
    private func configureGlobalAppStyle() {
        UINavigationBar.appearance().barTintColor = .appThemeBackground // solid background color
        UIBarButtonItem.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}

