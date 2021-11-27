//
//  DescriptionTableViewCell.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    struct Model {
        let description: String
    }
    
    // MARK: - Static Properties
    
    static let reuseIdentifier = "DescriptionTableViewCell"
 
    // MARK: - IBOutlet
    
    @IBOutlet private var descriptionLabel: UILabel!
    
    // MARK: - Public Methods
    
    func setViewState(_ model: Model) {
        self.descriptionLabel.text = model.description
    }
    
}
