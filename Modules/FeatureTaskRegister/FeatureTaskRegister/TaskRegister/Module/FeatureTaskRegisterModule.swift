//
//  FeatureTaskRegisterModule.swift
//  FeatureTaskRegister
//
//  Created by Dmitrii Voronin on 27.11.2021.
//

import Foundation
import UIKit
import Networking

public final class FeatureTaskRegisterModule {
    private let coordinator: Coordinator
    
    public init(navigationController: UINavigationController, apiSession: AsyncGenericApi, selfId: UUID) {
        let gatewayFactory = GatewayFactory(aqiSession: apiSession)
        let useCaseFactory = UseCaseFactory(gatewayFactory: gatewayFactory)
        let appModelFactory = AppModelFactory(selfId: selfId, useCaseFactory: useCaseFactory)
        let viewModelFactory = ViewModelFactory(appModelFactory: appModelFactory)
        let viewControllerFactory = ViewControllerFactory(viewModelFactory: viewModelFactory)

        coordinator = Coordinator(navigationController: navigationController, viewControllerFactory: viewControllerFactory)
    }
    
    public func setSelectionHandler(_ selectionHandler: @escaping (UINavigationController, @escaping (PublicSelectionItem) -> Void) -> Void) {
        coordinator.selectionHandler = { (nc, completion) in
            selectionHandler(nc, {
                switch $0 {
                case .folder(let folder):
                    let departament = Departament(folder)
                    completion(.folders([departament]))
                case .employee(let employee):
                    let employee = Employee(employee)
                    completion(.employees([employee]))
                }
            })
        }
    }
    
    public func start() {
        coordinator.showTasksListViewController()
    }
    
}

fileprivate extension Departament {
    init(_ model: PublicSelectionItem.Folder) {
        self.id = model.id
        self.name = model.name
    }
}

fileprivate extension Employee {
    init(_ model: PublicSelectionItem.Employee) {
        self.id = model.id
        self.name = model.name
        self.avatarUrl = model.avatarUrl
    }
}
