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
    
    func taskViewController(taskId: UUID) -> TaskViewController {
        let taskViewController = TaskViewController()
        taskViewController.viewModel = viewModelFactory.taskViewModel(taskId: taskId)
        return taskViewController
    }
    
    func editViewController(task: Task?) -> EditTaskViewController {
        let editViewController = EditTaskViewController()
        editViewController.viewModel = viewModelFactory.editTaskViewModel(editTask: task)
        return editViewController
    }
    
}
