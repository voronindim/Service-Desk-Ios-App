//
//  UseCaseFactory.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation

final class UseCaseFactory {
    
    private let gatewayFactory: GatewayFactory
    
    init(gatewayFactory: GatewayFactory) {
        self.gatewayFactory = gatewayFactory
    }
 
    func tasksListUseCase() -> TasksListUseCase {
        let useCase = TasksListUseCaseEmplementation(gateway: gatewayFactory.tasksListGateway())
        return useCase
    }
    
    func taskUseCase() -> TaskUseCase {
        let useCase = TaskUseCaseImplementation(gateway: gatewayFactory.taskGateway())
        return useCase
    }
    
    func editTaskUseCase() -> EditTaskUseCase {
        let useCase = EditTaskUseCaseImplementation(gateway: gatewayFactory.editTaskGateway())
        return useCase
    }
}
