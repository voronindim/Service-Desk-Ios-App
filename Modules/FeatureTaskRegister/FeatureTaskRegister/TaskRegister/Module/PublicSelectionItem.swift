//
//  PublicSelectionItem.swift
//  FeatureTaskRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation

public enum PublicSelectionItem {
    public struct Folder {
        public let id: UUID
        public let name: String
        
        public init(id: UUID, name: String) {
            self.id = id
            self.name = name
        }
        
    }
    
    public struct Employee {
        public let id: UUID
        public let name: String
        public let avatarUrl: URL?
        
        public init(id: UUID, name: String, avatarUrl: URL?) {
            self.id = id
            self.name = name
            self.avatarUrl = avatarUrl
        }
    }
    
    case folder(Folder)
    case employee(Employee)
}
