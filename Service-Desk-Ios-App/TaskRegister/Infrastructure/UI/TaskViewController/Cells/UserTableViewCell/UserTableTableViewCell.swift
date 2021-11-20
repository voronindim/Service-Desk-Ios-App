//
//  UserTableTableViewCell.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import UIKit

class UserTableTableViewCell: UITableViewCell {

    struct Model {
        let userName: String
        let avatarUrl: URL?
    }
    
    // MARK: - Static Properties
    
    static let reuseIdentifier = "UserTableTableViewCell"
    
    // MARK: - IBOutlet
    
    @IBOutlet private var userAvatarImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    
    // MARK: - Public Methods
    
    func setiViewState(_ model: Model) {
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.height / 2
        userNameLabel.text = model.userName
        // TODO: set image view
    }
    
    
}
