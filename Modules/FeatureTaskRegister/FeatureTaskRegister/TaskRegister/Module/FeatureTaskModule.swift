//
//  FeatureTaskModule.swift
//  FeatureTaskRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation
import UIKit

public final class FeatureTaskModule {
    private let coordinator: Coordinator
    
    public init(navigationController: UINavigationController) {
        let useCaseFactory = UseCaseFactory()
        let appModelFactory = AppModelFactory(useCaseFactory: useCaseFactory)
        let viewModelFactory = ViewModelFactory(appModelFactory: appModelFactory)
        let viewControllerFactory = ViewControllerFactory(viewModelFactory: viewModelFactory)

        coordinator = Coordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
    }
    
    public func start() {
        coordinator.showTasksListViewController()
    }
    
}
