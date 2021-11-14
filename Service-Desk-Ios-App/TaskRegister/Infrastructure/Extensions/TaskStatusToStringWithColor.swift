//
//  TaskStatusToStringWithColor.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation
import UIKit

struct StatusWithColor {
    let text: String
    let color: UIColor
}
func taskStatusToStringWithColor(_ status: TaskStatus) -> StatusWithColor {
    switch status {
    case .notStarted:
        return StatusWithColor(text: "not started", color: .systemGray)
    case .inProgress:
        return StatusWithColor(text: "in progress", color: .systemGray)
    case .review:
        return StatusWithColor(text: "review", color: .systemGray)
    case .closed:
        return StatusWithColor(text: "closed", color: .systemGray)
    }
}
