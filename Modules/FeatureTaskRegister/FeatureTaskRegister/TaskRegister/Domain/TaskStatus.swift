//
//  TaskStatus.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

enum TaskStatus: Equatable, Codable {
    case notStarted
    case inProgress
    case review
    case closed
}
