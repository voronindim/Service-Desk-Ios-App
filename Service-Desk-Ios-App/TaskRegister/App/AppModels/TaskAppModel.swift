//
//  TaskAppModel.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation
import RxSwift

final class TaskAppModel {
    
    // MARK: - Public Properties
    
    var state: Observable<TaskAppState> {
        stateSubject
    }
    
    // MARK: - Private Properties
    
    private let taskUseCase: TaskUseCase
    private let stateSubject = BehaviorSubject<TaskAppState>(value: .loading)
    
    // MARK: - Initialize
    
    init(taskUseCase: TaskUseCase) {
        self.taskUseCase = taskUseCase
    }
    
    // MARK: - Public Properties
    
    func reloadDetails() async {
        let result = await taskUseCase.detailsTask(id: UUID())
        switch result {
        case .success(let task):
            stateSubject.onNext(.loaded(task))
        case .failure(let useCaseError):
            stateSubject.onNext(.error(useCaseError))
        }
    }
    
    
}
