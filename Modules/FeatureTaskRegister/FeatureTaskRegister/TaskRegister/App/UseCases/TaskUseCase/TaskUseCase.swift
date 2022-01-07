//
//  TaskUseCase.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

protocol TaskUseCase {
    func detailsTask(id: UUID) async -> Result<UserTask, UseCasesError>
}
