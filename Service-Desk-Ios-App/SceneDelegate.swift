//
//  SceneDelegate.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import UIKit
import SwiftUI
import FeatureTaskRegister
import FeatureEmployeesRegister
import FeatureLogin


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    private let tabBarControllerFactory = TabBarControllerFactory()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let loginNavigationController = UINavigationController()
        let loginModule = LoginModule(rootNavigationController: loginNavigationController, successLoginHandler: { [weak self] in
            self?.setupTabBarController()
        })

        window?.rootViewController = loginNavigationController
        loginModule.start()
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    private func setupTabBarController() {
        window?.rootViewController = tabBarControllerFactory.tabBarController([.tasks, .employees])
    }

}
