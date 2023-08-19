//
//  AppDelegate.swift
//  StarWars
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Life Cycle

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

