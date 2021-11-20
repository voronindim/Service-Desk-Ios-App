//
//  ChangeStatusUseCase.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import Foundation

protocol ChangeStatusUseCase {
    func changeStatus(taskId: UUID, status: TaskStatus) async -> Result<Void, UseCasesError>
}
