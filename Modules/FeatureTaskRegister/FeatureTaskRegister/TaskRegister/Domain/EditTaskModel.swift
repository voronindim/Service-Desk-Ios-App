//
//  NewTaskModel.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 24.11.2021.
//

import Foundation

struct EditTaskModel: Encodable {
    let id: UUID?
    let title: String
    let description: String
    let endDate: Date
    let creator: Employee
    let assigned: Employee?
    let departament: Departament?
}
