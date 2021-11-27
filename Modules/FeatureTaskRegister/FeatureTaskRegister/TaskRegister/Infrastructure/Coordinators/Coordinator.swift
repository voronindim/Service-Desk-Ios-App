//
//  Coordinator.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation
import UIKit

final class Coordinator {
    
    var selectionHandler: ((UINavigationController, @escaping (SelectionItem) -> Void) -> Void)?
    
    private let viewControllerFactory: ViewControllerFactory
    private var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController, viewControllerFactory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }
    
    func popToRootViewController(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func popViewController(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
}

// MARK: - Show Methods

extension Coordinator {
    
    func showTasksListViewController() {
        let viewController = viewControllerFactory.tasksListViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showTaskViewController(taskId: UUID) {
        let viewController = viewControllerFactory.taskViewController(taskId: taskId)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showEditViewController(task: Task?) {
        let viewController = viewControllerFactory.editViewController(task: task)
        viewController.closeHandler = { self.navigationController.dismiss(animated: true) }
        viewController.selectAssignedHandler = selectionHandler
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController.present(navController, animated: true)
    }
    
}
