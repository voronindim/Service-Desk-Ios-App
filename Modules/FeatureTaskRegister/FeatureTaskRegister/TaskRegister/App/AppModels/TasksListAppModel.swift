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
    private let selfId: UUID
    private var updateFor: UpdateFor {
        didSet {
            reload()
        }
    }
    
    // MARK: - Initialize
    
    init(selfId: UUID, tasksListUseCase: TasksListUseCase) {
        self.selfId = selfId
        self.tasksListUseCase = tasksListUseCase
        self.updateFor = .me
        self.stateSubject.onNext(.loading)
        reloadList(userId: selfId)
    }
    
    // MARK: - Public Methods
    
    func reload() {
        switch updateFor {
        case .me:
            reloadList(userId: selfId)
        case .fromMe:
            reloadTasksListFromMe()
        case .department(let uUID):
            reloadList(departmentId: uUID)
        case .employee(let uUID):
            reloadList(userId: uUID)
        }
    }
    
    func tasksListOnMe() {
        updateFor = .me
    }
    
    func tasksListFromMe() {
        updateFor = .fromMe
    }
    
    func updateDepartmentList(uuid: UUID) {
        updateFor = .department(uuid)
    }
    
    func updatePersonList(uuid: UUID) {
        updateFor = uuid == selfId ? .me : .employee(uuid)
    }
    
    private func reloadTasksListFromMe() {
        Task {
            let result = await tasksListUseCase.tasksFromMe(creatorId: selfId)
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
    
    private func reloadList(userId: UUID) {
        Task {
            let result = await tasksListUseCase.reload(userId: userId)
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
    
    private func reloadList(departmentId: UUID) {
        Task {
            let result = await tasksListUseCase.reload(departmentId: departmentId)
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
