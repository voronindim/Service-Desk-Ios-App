//
//  TasksListUseCase.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

protocol TasksListUseCase {
    func reload(userId: UUID) async -> Result<[UserTask], UseCasesError>
    func reload(departmentId: UUID) async -> Result<[UserTask], UseCasesError>
    func tasksFromMe(creatorId: UUID) async -> Result<[UserTask], UseCasesError>
}
