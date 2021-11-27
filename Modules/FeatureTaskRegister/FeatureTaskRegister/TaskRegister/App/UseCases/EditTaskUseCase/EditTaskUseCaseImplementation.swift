//
//  EditTaskUseCaseImplementation.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 21.11.2021.
//

import Foundation

final class EditTaskUseCaseImplementation: EditTaskUseCase {
    func editTask(_ task: EditTaskModel) async -> Result<Void, UseCasesError> {
        .failure(.unknownError)
    }
}
