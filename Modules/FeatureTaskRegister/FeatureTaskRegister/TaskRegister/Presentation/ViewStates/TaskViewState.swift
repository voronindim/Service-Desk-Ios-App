//
//  TaskViewState.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import Foundation

struct TaskViewState {
    let id: UUID
    let title: String
    let description: String
    var status: TaskStatus
    let createdDate: Date
    let endDate: Date
    let creator: Employee
    let assigned: Employee
    let departament: Departament
}

extension TaskViewState {
    init(model: Task) {
        self.init(
            id: model.id,
            title: model.title,
            description: model.description,
            status: model.status,
            createdDate: model.createdDate,
            endDate: model.endDate,
            creator: model.creator,
            assigned: model.assigned,
            departament: model.departament
        )
    }
}
