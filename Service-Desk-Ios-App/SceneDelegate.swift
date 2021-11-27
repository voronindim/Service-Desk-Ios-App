//
//  SceneDelegate.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import UIKit
import FeatureTaskRegister

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tasksNavigationController = UINavigationController()
        let tasksModule = FeatureTaskRegisterModule(navigationController: tasksNavigationController)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([tasksNavigationController], animated: true)

        window?.rootViewController = tabBarController
        tasksModule.start()
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


}

