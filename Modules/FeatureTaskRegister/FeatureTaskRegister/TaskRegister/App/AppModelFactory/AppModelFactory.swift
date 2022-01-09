//
//  AppModelFactory.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation

final class AppModelFactory {
    private let useCaseFactory: UseCaseFactory
    private let selfInfo: Employee
    
    init(selfId: UUID, useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
        self.selfInfo = Employee(id: selfId, name: "", avatarUrl: nil)
    }
    
    func tasksListAppModel() -> TasksListAppModel {
        TasksListAppModel(selfId: selfInfo.id, tasksListUseCase: useCaseFactory.tasksListUseCase())
    }
    
    func taskAppModel(taskId: UUID) -> TaskAppModel {
        TaskAppModel(taskId: taskId, taskUseCase: useCaseFactory.taskUseCase(), changeStatusUseCase: useCaseFactory.changeStatusUseCase())
    }
    
    func editTaskAppModel(task: UserTask?) -> EditTaskAppModel {
        EditTaskAppModel(editTaskUseCase: useCaseFactory.editTaskUseCase(), selfInfo: selfInfo, editTask: task)
    }
}
