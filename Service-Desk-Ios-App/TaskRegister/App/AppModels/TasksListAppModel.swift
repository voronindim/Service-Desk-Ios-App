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
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.stateSubject.onNext(.loaded(mockTasks1))
        })
        
    }
    
    // MARK: - Public Methods
    
    func reloadTasksList() {
        stateSubject.onNext(.loaded(mockTasks1))
//        let result = await tasksListUseCase.reload(userId: UUID())
//        switch result {
//        case .success(let tasks):
//            stateSubject.onNext(.loaded(tasks))
//        case .failure(let useCaseError):
//            stateSubject.onNext(.error(useCaseError))
//        }
    }
    
}

var mockTasks1: [Task] = [
    .init(id: UUID(), title: "kjashdfkajshdf", description: "askljasdl", status: .closed, createdDate: Date(), endDate: Date(), creator: .init(id: UUID(), name: "asdlk;fjas", avatarUrl: nil), assigned: .init(id: UUID(), name: "qpowei", avatarUrl: nil), departament: .init(id: UUID(), name: "123")),
    .init(id: UUID(), title: "kjashdfkajshdf", description: "askljasdl", status: .closed, createdDate: Date(), endDate: Date(), creator: .init(id: UUID(), name: "asdlk;fjas", avatarUrl: nil), assigned: .init(id: UUID(), name: "qpowei", avatarUrl: nil), departament: .init(id: UUID(), name: "123")),
    .init(id: UUID(), title: "kjashdfkajshdf", description: "askljasdl", status: .closed, createdDate: Date(), endDate: Date(), creator: .init(id: UUID(), name: "asdlk;fjas", avatarUrl: nil), assigned: .init(id: UUID(), name: "qpowei", avatarUrl: nil), departament: .init(id: UUID(), name: "123")),
    .init(id: UUID(), title: "kjashdfkajshdf", description: "askljasdl", status: .closed, createdDate: Date(), endDate: Date(), creator: .init(id: UUID(), name: "asdlk;fjas", avatarUrl: nil), assigned: .init(id: UUID(), name: "qpowei", avatarUrl: nil), departament: .init(id: UUID(), name: "123")),
    .init(id: UUID(), title: "kjashdfkajshdf", description: "askljasdl", status: .closed, createdDate: Date(), endDate: Date(), creator: .init(id: UUID(), name: "asdlk;fjas", avatarUrl: nil), assigned: .init(id: UUID(), name: "qpowei", avatarUrl: nil), departament: .init(id: UUID(), name: "123")),
]
