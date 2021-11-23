//
//  InstantiateFromStoryboard.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 23.11.2021.
//

import UIKit

public protocol InstantiateFromStoryboard where Self: UIViewController {
    static var storyboardName: String { get }
    static var viewControllerIdentifier: String? { get }
}

public extension InstantiateFromStoryboard {
    static var viewControllerIdentifier: String? { nil }
    
    static func instantiateFromStoryboard() -> Self? {
        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: Self.storyboardName, bundle: bundle)
        
        guard let id = Self.viewControllerIdentifier else {
            return storyboard.instantiateInitialViewController() as? Self
        }
        return storyboard.instantiateViewController(identifier: id) as? Self
    }
}
