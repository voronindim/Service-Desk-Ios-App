//
//  EditTaskUseCase.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 21.11.2021.
//

import Foundation

protocol EditTaskUseCase {
    func editTask(_ task: Task) async -> Result<Void, UseCasesError>
}
