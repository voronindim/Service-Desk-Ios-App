//
//  TasksLIstUseCaseImplementation.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

final class TasksListUseCaseEmplementation: TasksListUseCase {
    
    private let gateway: TasksListGateway
    
    init(gateway: TasksListGateway) {
        self.gateway = gateway
    }
    
    func reload(userId: UUID) async -> Result<[UserTask], UseCasesError> {
        switch await gateway.reload(userId: userId) {
        case .success(let tasks):
            return .success(tasks)
        case .failure(_):
            return .failure(.unknownError)
        }
    }
    
    func reload(departmentId: UUID) async -> Result<[UserTask], UseCasesError> {
        switch await gateway.reload(departmentId: departmentId) {
        case .success(let tasks):
            return .success(tasks)
        case .failure(_):
            return .failure(.unknownError)
        }
    }
    
}
