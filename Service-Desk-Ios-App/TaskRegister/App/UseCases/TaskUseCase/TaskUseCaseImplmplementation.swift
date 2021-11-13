//
//  TaskUseCaseImplmplementation.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

final class TaskUseCaseImplementation: TaskUseCase {
    func detailsTask(id: UUID) async -> Result<Task, UseCasesError> {
        .failure(.unknownError)
    }
}
