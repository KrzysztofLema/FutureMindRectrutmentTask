//
//  SceneDelegate.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 07/04/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let appDependencyContainer = AppDependencyContainer()
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewController = appDependencyContainer.makeViewController()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}
