//
//  EditTaskAppModel.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 21.11.2021.
//

import Foundation
import RxSwift

final class EditTaskAppModel {
    
    // MARK: - Public Properties
    
    var state: Observable<EditTaskState> {
        stateSubject
    }
    
    var successEdit: Observable<Bool> {
        successEditSubject
    }
    
    // MARK: - Private Properties
    
    private let stateSubject: BehaviorSubject<EditTaskState>
    private let editTaskUseCase: EditTaskUseCase
    private let successEditSubject = PublishSubject<Bool>()
    
    // MARK: - Initialize
    
    init(editTaskUseCase: EditTaskUseCase, selfInfo: Employee, editTask: UserTask?) {
        self.editTaskUseCase = editTaskUseCase
        if let editTask = editTask {
            stateSubject = .init(value: .edit(editTask))
        } else {
            stateSubject = .init(value: .create(selfInfo))
        }
    }
    
    func applyTask(_ model: EditTaskModel) {
        Task {
            let result = await editTaskUseCase.editTask(model)
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.successEditSubject.onNext(true)
                case .failure(_):
                    self.successEditSubject.onNext(false)
                }
            }
        }
    }
    
}
