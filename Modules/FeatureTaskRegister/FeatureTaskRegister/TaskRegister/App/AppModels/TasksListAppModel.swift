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
        self.stateSubject.onNext(.loading)
        reloadTasksList()
    }
    
    // MARK: - Public Methods
    
    func reloadTasksList() {
        Task {
            let result = await tasksListUseCase.reload(userId: UUID())
            DispatchQueue.main.async {
                switch result {
                case .success(let tasks):
                    self.stateSubject.onNext(.loaded(tasks))
                case .failure(let useCaseError):
                    self.stateSubject.onNext(.error(useCaseError))
                }
            }
        }

    }
    
}
