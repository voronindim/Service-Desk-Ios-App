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
    private let stateSubject = BehaviorSubject<TaskAppState>(value: .loading)
    
    // MARK: - Initialize
    
    init(taskId: UUID, taskUseCase: TaskUseCase) {
        self.taskId = taskId
        self.taskUseCase = taskUseCase
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let random = Int.random(in: 0...4)
            self.stateSubject.onNext(.loaded(random <= 2 ? mock : mock2))
        }
    }
    
    // MARK: - Public Properties
    
    func reloadDetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let random = Int.random(in: 0...4)
            self.stateSubject.onNext(.loaded(random <= 2 ? mock : mock2))
//            self.stateSubject.onNext(.error(.unknownError))
        }

//        let result = await taskUseCase.detailsTask(id: UUID())
//        switch result {
//        case .success(let task):
//            stateSubject.onNext(.loaded(task))
//        case .failure(let useCaseError):
//            stateSubject.onNext(.error(useCaseError))
//        }
    }
    
    func statusDidChanges(_ status: TaskStatus) {
        // TODO: UseCase
    }
    
}

fileprivate var mock = Task(
    id: UUID(),
    title: "Рейтинги в Мотивации iOS. Не прогружается фон рейтинга после обновления приложения со старой версии на новую",
    description: "Рейтинги в Мотивации iOS. Не прогружается фон рейтинга после обновления приложения со старой версии на новую",
    status: .closed,
    createdDate: Date(),
    endDate: Date(),
    creator: .init(id: UUID(),
                   name: "Дмитрий Воронин",
                   avatarUrl: nil),
    assigned: .init(id: UUID(),
                    name: "Анна Гладышева",
                    avatarUrl: nil),
    departament: .init(id: UUID(), name: "123")
)


fileprivate var mock2 = Task(
    id: UUID(),
    title: "Рейтинги dожения со старой версии на новую",
    description: "Рейтинги в Мрейтинга после обновления приложения со старой версии на новую",
    status: .closed,
    createdDate: Date(),
    endDate: Date(),
    creator: .init(id: UUID(),
                   name: "Дми2",
                   avatarUrl: nil),
    assigned: .init(id: UUID(),
                    name: "Анна Гла3ва",
                    avatarUrl: nil),
    departament: .init(id: UUID(), name: "123")
)
