//
//  ViewModelFactory.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation

final class ViewModelFactory {
    private let appModelFactory: AppModelFactory
    
    init(appModelFactory: AppModelFactory) {
        self.appModelFactory = appModelFactory
    }
    
    func tasksListViewModel() -> TasksListViewModel {
        let appModel = appModelFactory.tasksListAppModel()
        return TasksListViewModel(appModel: appModel)
    }
    
    func taskViewModel(taskId: UUID) -> TaskViewModel {
        let appModel = appModelFactory.taskAppModel(taskId: taskId)
        return TaskViewModel(appModel: appModel)
    }
    
    func editTaskViewModel(editTask: Task?) -> EditTaskViewModel {
        let appModel = appModelFactory.editTaskAppModel(task: editTask)
        return EditTaskViewModel(appModel: appModel)
    }
}
