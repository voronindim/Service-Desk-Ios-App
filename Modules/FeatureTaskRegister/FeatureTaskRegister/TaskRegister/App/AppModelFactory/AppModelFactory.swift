//
//  AppModelFactory.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation

final class AppModelFactory {
    private let useCaseFactory: UseCaseFactory
    private let selfInfo: Employee = .init(id: UUID(), name: "Hardcode Dmitrii Voronin", avatarUrl: nil)
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    func tasksListAppModel() -> TasksListAppModel {
        TasksListAppModel(tasksListUseCase: useCaseFactory.tasksListUseCase())
    }
    
    func taskAppModel(taskId: UUID) -> TaskAppModel {
        TaskAppModel(taskId: taskId, taskUseCase: useCaseFactory.taskUseCase())
    }
    
    func editTaskAppModel(task: UserTask?) -> EditTaskAppModel {
        EditTaskAppModel(editTaskUseCase: useCaseFactory.editTaskUseCase(), selfInfo: selfInfo, editTask: task)
    }
}
