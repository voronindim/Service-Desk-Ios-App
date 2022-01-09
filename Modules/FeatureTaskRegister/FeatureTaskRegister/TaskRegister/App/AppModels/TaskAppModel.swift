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
    
    private let taskId: UUID
    private let taskUseCase: TaskUseCase
    private let changeStatusUseCase: ChangeStatusUseCase
    private let stateSubject = BehaviorSubject<TaskAppState>(value: .loading)
    
    // MARK: - Initialize
    
    init(taskId: UUID, taskUseCase: TaskUseCase, changeStatusUseCase: ChangeStatusUseCase) {
        self.taskId = taskId
        self.taskUseCase = taskUseCase
        self.changeStatusUseCase = changeStatusUseCase
        reloadDetails()
    }
    
    // MARK: - Public Properties
    
    func reloadDetails() {
        Task {
            let result = await taskUseCase.detailsTask(id: taskId)
            DispatchQueue.main.async {
                switch result {
                case .success(let task):
                    self.stateSubject.onNext(.loaded(task))
                case .failure(let useCaseError):
                    self.stateSubject.onNext(.error(useCaseError))
                }
            }
        }
    }
    
    func statusDidChanges(_ status: TaskStatus) {
        Task {
            let result = await changeStatusUseCase.changeStatus(taskId: taskId, status: status)
            DispatchQueue.main.async {
                switch result {
                case .success():
                    return
                case .failure(_):
                    self.stateSubject.onNext(.error(.chnageStatusError))
                }
            }
        }
    }
    
}
