//
//  TitleAndEndDateTableViewCell.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import UIKit

class TitleAndEndDateTableViewCell: UITableViewCell {

    struct Model {
        let title: String
        let endDate: Date
    }
    
    // MARK: - Static Properties
    
    static let reuseIdentifier = "TitleAndEndDateTableViewCell"
    
    // MARK: - @IBOutlet
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var endDateLabel: UILabel!
    
    // MARK: - Public Methods
    
    func setViewState(_ model: Model) {
        titleLabel.text = model.title
        endDateLabel.text = model.endDate.toString(dateStyle: .medium, timeStyle: .none)
    }
    
}
