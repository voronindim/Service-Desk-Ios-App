//
//  TasksListUseCase.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

protocol TasksListUseCase {
    func reload(userId: UUID) async -> Result<[Task], UseCasesError>
}
