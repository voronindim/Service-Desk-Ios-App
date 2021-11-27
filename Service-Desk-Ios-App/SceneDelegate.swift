//
//  SceneDelegate.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import UIKit
import FeatureTaskRegister
import FeatureEmployeesRegister

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tasksNavigationController = UINavigationController()
        let tasksModule = FeatureTaskRegisterModule(navigationController: tasksNavigationController)
        
        let employeesNavigationController = UINavigationController()
        let structureModule = EmployeesRegisterModule(navigationController: employeesNavigationController, mode: .show)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([tasksNavigationController, employeesNavigationController], animated: true)
        
        window?.rootViewController = tabBarController
        
        tasksModule.start()
        structureModule.start()
        
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

