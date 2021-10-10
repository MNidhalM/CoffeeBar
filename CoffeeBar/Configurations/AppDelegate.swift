//
//  AppDelegate.swift
//  CoffeeBar
//
//  Created by Nidhal on 7/10/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        setupWindow()
        return true
    }

    func setupWindow() {
        window?.overrideUserInterfaceStyle = .light
        let rootNavC = UINavigationController(rootViewController: ScanViewController.instantiateFromStoryboard(mainStoryboard))
        rootNavC.isNavigationBarHidden = true
        window?.rootViewController = rootNavC
        window?.makeKeyAndVisible()
    }

}

