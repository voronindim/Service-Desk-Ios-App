//
//  TasksListAppModel.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation
import RxSwift

final class TasksListAppModel {
    
    // MARK: - Public Properties 
    
    var state: Observable<TasksListAppState> {
        stateSubject
    }
    
    // MARK: - Private Properties
    
    private let tasksListUseCase: TasksListUseCase
    private let stateSubject = BehaviorSubject<TasksListAppState>(value: .loading)
    
    // MARK: - Initialize
    
    init(tasksListUseCase: TasksListUseCase) {
        self.tasksListUseCase = tasksListUseCase
    }
    
    // MARK: - Public Methods
    
    func reloadTasksList() async {
        let result = await tasksListUseCase.reload(userId: UUID())
        switch result {
        case .success(let tasks):
            stateSubject.onNext(.loaded(tasks))
        case .failure(let useCaseError):
            stateSubject.onNext(.error(useCaseError))
        }
    }
    
}
