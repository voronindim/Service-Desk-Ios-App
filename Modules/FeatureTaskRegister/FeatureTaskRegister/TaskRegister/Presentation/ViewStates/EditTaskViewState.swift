//
//  EditTaskViewState.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 21.11.2021.
//

import Foundation

struct EditTaskViewState: Equatable {
    let id: UUID?
    var title: String
    var description: String
    var status: TaskStatus
    let createdDate: Date
    var endDate: Date?
    let creator: Employee
    var assigned: Employee?
    var departament: Departament?
}

extension EditTaskViewState {
    
    init(creator: Employee) {
        self.init(
            id: nil,
            title: "",
            description: "",
            status: .notStarted,
            createdDate: Date(),
            endDate: nil,
            creator: creator,
            assigned: nil,
            departament: nil
        )
    }
    
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
            departament: model.departament
        )
    }
}
