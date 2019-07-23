//
//  AppDelegate.swift
//  ESTest
//
//  Created by Eugene Syrtcov on 7/22/19.
//  Copyright © 2019 ESTest. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = createRootViewController()
        window?.makeKeyAndVisible()
        return true
    }

    private func createRootViewController() -> UIViewController {
        let viewController = DetailViewController()
        viewController.viewModel = DetailViewModel()
        return viewController
    }

}

