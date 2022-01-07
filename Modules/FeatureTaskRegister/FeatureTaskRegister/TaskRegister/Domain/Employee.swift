//
//  Employee.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

struct Employee: Equatable, Codable {
    let id: UUID
    let name: String
    let avatarUrl: URL?
}
