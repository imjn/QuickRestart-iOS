//
//  AppDelegate.swift
//  QuickRestart
//
//  Created by Imagine Kawabe on 2019/06/29.
//  Copyright © 2019 Imagine Kawabe. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        configureInitialRootViewController(for: window)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate {
    func configureInitialRootViewController(for window: UIWindow?) {

        if UserDefaults.standard.string(forKey: "username") != nil {
            let initialViewController = UIStoryboard.initialViewController(for: .Main)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        } else {
            let initialViewController = UIStoryboard.initialViewController(for: .SignIn)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }

    }
}

extension UIStoryboard {

    convenience init(type: SBType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }

    enum SBType: String {
        case Main
        case SignIn

        var filename: String {
            return rawValue
        }
    }

    static func initialViewController(for type: SBType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        return initialViewController
    }

    static func moveToAnotherStoryboard(for type: SBType, currentView: UIViewController) -> Void {
        let initialViewController = self.initialViewController(for: type)
        currentView.view.window?.rootViewController = initialViewController
        currentView.view.window?.makeKeyAndVisible()
    }
}

