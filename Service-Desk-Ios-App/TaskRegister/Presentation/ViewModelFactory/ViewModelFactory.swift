//
//  ViewModelFactory.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import Foundation

final class ViewModelFactory {
    private let appModelFactory: AppModelFactory
    
    init(appModelFactory: AppModelFactory) {
        self.appModelFactory = appModelFactory
    }
    
    func tasksListViewModel() -> TasksListViewModel {
        let appModel = appModelFactory.tasksListAppModel()
        return TasksListViewModel(appModel: appModel)
    }
}