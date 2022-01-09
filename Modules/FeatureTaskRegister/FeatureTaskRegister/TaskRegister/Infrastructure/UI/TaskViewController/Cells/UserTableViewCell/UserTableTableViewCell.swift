//
//  UserTableTableViewCell.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import UIKit
import Kingfisher

class UserTableTableViewCell: UITableViewCell {

    struct Model {
        let userName: String
        let avatarUrl: URL?
    }
    
    struct DepartmentModel {
        let name: String
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
        if let url = model.avatarUrl {
            userAvatarImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.fill")?.withTintColor(.gray))
        } else {
            userAvatarImageView.image = UIImage(systemName: "person.fill")
        }
    }
    
    func setViewState(_ model: DepartmentModel) {
        userAvatarImageView.layer.cornerRadius = userAvatarImageView.frame.height / 2
        userAvatarImageView.image = UIImage(systemName: "person.3.fill")
        userNameLabel.text = model.name
        
    }
    
    
}
