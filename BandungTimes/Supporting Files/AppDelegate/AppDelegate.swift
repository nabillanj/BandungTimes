//
//  AppDelegate.swift
//  BandungTimes
//
//  Created by nabilla on 26/08/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let splashscreenVc = SplashcreenViewController.instantiateFrom(storyboard: .main)
        setRootViewController(controller: splashscreenVc)
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")

        return true
    }

    private func setRootViewController(controller: UIViewController) {
        let nvc: UINavigationController = UINavigationController(rootViewController: controller)
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = nvc
        self.window?.makeKeyAndVisible()
    }
}

