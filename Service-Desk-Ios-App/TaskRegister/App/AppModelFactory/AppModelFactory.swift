//
//  AppModelFactory.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation

final class AppModelFactory {
    private let useCaseFactory: UseCaseFactory
    
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    func tasksListAppModel() -> TasksListAppModel {
        TasksListAppModel(tasksListUseCase: useCaseFactory.tasksListUseCase())
    }
    
    func taskAppModel() -> TaskAppModel {
        TaskAppModel(taskUseCase: useCaseFactory.taskUseCase())
    }
}
