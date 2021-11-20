//
//  EditTaskState.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 21.11.2021.
//

import Foundation

enum EditTaskState {
    case edit(_ task: Task)
    case create(_ selfInfo: Employee)
}
