//
//  AppDelegate.swift
//  SmallWorldTest_UIKit
//
//  Created by Sabih Haris on 10/12/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        navigateToHomeViewController()
        
        return true
    }

    
    private func navigateToHomeViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let timeline = MoviesViewController.initWithNib()
            let navigationViewController = UINavigationController(rootViewController: timeline)
            ViewPresenter.replaceRootView(for: navigationViewController)
        }
    }
    
   

  


}

