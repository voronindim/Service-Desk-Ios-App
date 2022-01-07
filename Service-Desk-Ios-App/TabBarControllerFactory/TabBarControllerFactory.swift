//
//  TabBarControllerFactory.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 02.12.2021.
//

import Foundation
import UIKit
import FeatureTaskRegister
import FeatureEmployeesRegister
import Networking

final class TabBarControllerFactory {
    func tabBarController(_ items: [TabBarItems]) -> UITabBarController {
        var controllers = [UIViewController]()
        
        items.forEach({
            switch $0 {
            case .tasks:
                controllers.append(tasksTabBarItemController())
            case .employees:
                controllers.append(employeesTabBarItemController())
            }
        })
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(controllers, animated: true)
        return tabBarController
    }
    
    // MARK: - Private Methods
    
    private func tasksTabBarItemController() -> UIViewController {
        let tasksNavigationController = UINavigationController()
        let module = FeatureTaskRegisterModule(navigationController: tasksNavigationController, apiSession: AsyncGenericApi())
        setupTaskModule(module)
        module.start()
        tasksNavigationController.tabBarItem.image = UIImage(systemName: "folder.badge.questionmark")
        return tasksNavigationController
    }
    
    private func setupTaskModule(_ taskModule: FeatureTaskRegisterModule) {
        taskModule.setSelectionHandler { navigationController, completion in
            let module = EmployeesRegisterModule(navigationController: navigationController, mode: .oneSelected, selectionHandler: {
                switch $0 {
                case .employees(let employees):
                    let employee = employees.first!
                    completion(.employee(.init(id: employee.id, name: employee.name, avatarUrl: employee.avatarUrl)))
                case .folders(let folders):
                    let folder = folders.first!
                    completion(.folder(.init(id: folder.id, name: folder.name)))
                }
            })
            module.start()
        }
    }
    
    private func employeesTabBarItemController() -> UIViewController {
        let employeesNavigationController = UINavigationController()
        let module = EmployeesRegisterModule(navigationController: employeesNavigationController, mode: .show)
        module.start()
        employeesNavigationController.tabBarItem.image = UIImage(systemName: "person")
        return employeesNavigationController
    }
    
}
