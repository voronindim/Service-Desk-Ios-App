//
//  UseCaseFactory.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation

final class UseCaseFactory {
    
    func tasksListUseCase() -> TasksListUseCase {
        let useCase = TasksListUseCaseEmplementation()
        return useCase
    }
    
    func taskUseCase() -> TaskUseCase {
        let useCase = TaskUseCaseImplementation()
        return useCase
    }
    
    func editTaskUseCase() -> EditTaskUseCase {
        let useCase = EditTaskUseCaseImplementation()
        return useCase
    }
}
