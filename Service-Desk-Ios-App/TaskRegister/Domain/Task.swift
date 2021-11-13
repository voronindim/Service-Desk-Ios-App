//
//  Task.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

struct Task {
    let id: UUID
    let title: String
    let description: String
    let status: TaskStatus
    let createdDate: Date
    let endDate: Date
    let creator: Employee
    let assigned: Employee
    let departament: Departament
}
