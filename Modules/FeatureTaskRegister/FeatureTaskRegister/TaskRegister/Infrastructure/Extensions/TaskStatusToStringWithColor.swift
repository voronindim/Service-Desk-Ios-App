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
        return StatusWithColor(text: "Не начат", color: .systemGray)
    case .inProgress:
        return StatusWithColor(text: "Выполнение", color: .systemBlue)
    case .review:
        return StatusWithColor(text: "Проверка", color: .systemOrange)
    case .closed:
        return StatusWithColor(text: "Выполнен", color: .systemGreen)
    }
}
