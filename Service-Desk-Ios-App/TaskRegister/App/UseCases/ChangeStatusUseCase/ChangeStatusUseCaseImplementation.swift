//
//  ChangeStatusUseCaseImplementation.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import Foundation

final class ChangeStatusUseCaseImplementation: ChangeStatusUseCase {
    func changeStatus(taskId: UUID, status: TaskStatus) async -> Result<Void, UseCasesError> {
        .failure(.unknownError)
    }
}
