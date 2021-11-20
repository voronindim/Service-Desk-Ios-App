//
//  StatusTableViewCell.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static let reuseIdentifier = "StatusTableViewCell"
    
    @IBOutlet private var statusLabel: UILabel!
    
    func setViewState(status: TaskStatus) {
        let statusWithColor = taskStatusToStringWithColor(status)
        statusLabel.text = statusWithColor.text
        statusLabel.textColor = statusWithColor.color
    }
}
