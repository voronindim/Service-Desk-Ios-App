//
//  ChangeStatusUseCaseImplementation.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import Foundation

final class ChangeStatusUseCaseImplementation: ChangeStatusUseCase {
    
    private let gateway: ChangeStatusGateway
    
    init(gateway: ChangeStatusGateway) {
        self.gateway = gateway
    }
    
    func changeStatus(taskId: UUID, status: TaskStatus) async -> Result<Void, UseCasesError> {
        switch await gateway.changeStatus(taskId, status: status) {
        case .success:
            return .success(())
        case .failure(_):
            return .failure(.unknownError)
        }
    }
}
