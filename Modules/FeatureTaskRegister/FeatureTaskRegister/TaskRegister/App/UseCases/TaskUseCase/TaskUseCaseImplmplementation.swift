//
//  TaskUseCaseImplmplementation.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

final class TaskUseCaseImplementation: TaskUseCase {
    private let gateway: TaskGateway
    
    init(gateway: TaskGateway) {
        self.gateway = gateway
    }
    
    func detailsTask(id: UUID) async -> Result<UserTask, UseCasesError> {
        switch await gateway.details(id: id) {
        case .success(let task):
            return .success(task)
        case .failure(_):
            return .failure(.unknownError)
        }
    }
}
