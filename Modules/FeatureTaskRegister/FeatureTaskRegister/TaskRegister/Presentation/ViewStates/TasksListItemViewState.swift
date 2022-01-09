//
//  TasksListItemViewState.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

struct TasksListItemViewState {
    let id: UUID
    let title: String
    let description: String
    let status: TaskStatus
    let createdDate: Date
    let endDate: Date
    let creator: Employee
    let assigned: Employee?
    let department: Departament?
}

extension TasksListItemViewState {
    init(model: UserTask) {
        self.init(
            id: model.id,
            title: model.title,
            description: model.description,
            status: model.status,
            createdDate: model.createdDate,
            endDate: model.endDate,
            creator: model.creator,
            assigned: model.assigned,
            department: model.departament
        )
    }
}
