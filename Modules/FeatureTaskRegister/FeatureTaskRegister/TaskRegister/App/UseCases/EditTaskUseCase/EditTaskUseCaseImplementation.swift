//
//  EditTaskUseCaseImplementation.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 21.11.2021.
//

import Foundation

final class EditTaskUseCaseImplementation: EditTaskUseCase {
    
    private let gateway: EditTaskGateway
    
    init(gateway: EditTaskGateway) {
        self.gateway = gateway
    }
    
    
    func editTask(_ task: EditTaskModel) async -> Result<Void, UseCasesError> {
        switch await gateway.edit(model: task) {
        case .success(_):
            return .success(())
        case .failure(_):
            return .failure(.unknownError)
        }
    }
}
