//
//  SceneDelegate.swift
//  StarWars
//
//  Created by Arman Arutiunov on 18/08/2023.
//

import Filmography
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties

    var window: UIWindow?

    // MARK: - Life Cycle

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = FilmographySplitViewController()
        window?.makeKeyAndVisible()
    }
}

