//
//  TaskStatus.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation

enum TaskStatus: Int, Equatable, Codable {
    case notStarted = 0
    case inProgress = 1
    case review = 2
    case closed = 3
}
