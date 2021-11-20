//
//  TasksListTableViewCell.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import UIKit

class TasksListTableViewCell: UITableViewCell {

    static let reuseIdentidier = "TasksListTableViewCell"
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var creatorAvatarImageView: UIImageView!
    @IBOutlet private var creatorNameLabel: UILabel!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var endDateLabel: UILabel!
    
    func setViewState(_ state: TasksListItemViewState) {
        titleLabel.text = state.title
        descriptionLabel.text = state.description
        setStatus(state.status)
        setCreator(state.creator)
        endDateLabel.text = state.endDate.toString(dateStyle: .medium, timeStyle: .none)
    }
    
    private func setStatus(_ status: TaskStatus) {
        let statusWithColor = taskStatusToStringWithColor(status)
        statusLabel.text = statusWithColor.text
        statusLabel.textColor = statusWithColor.color
    }
    
    private func setCreator(_ creator: Employee) {
        creatorNameLabel.text = creator.name
        // TODO: set avatar
    }
}
