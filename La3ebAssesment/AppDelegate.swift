//
//  AppDelegate.swift
//  La3ebAssesment
//
//  Created by Sharaf on 23/05/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: GamesViewController())
       
        window?.rootViewController = UINavigationController(rootViewController: GamesViewController())
        navigationController.navigationBar.prefersLargeTitles = true
        
        return true
    }


}

