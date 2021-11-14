//
//  ViewControllerFactory.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation
import UIKit

final class ViewControllerFactory {
    private let viewModelFactory: ViewModelFactory
    
    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
    
    func tasksListViewController() -> TasksListViewController {
        let tasksListViewController = TasksListViewController()
        tasksListViewController.viewModel = viewModelFactory.tasksListViewModel()
        return tasksListViewController
    }
}
