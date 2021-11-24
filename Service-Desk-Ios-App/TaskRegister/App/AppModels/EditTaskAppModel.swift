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
    
    // MARK: - Private Properties
    
    private let stateSubject: BehaviorSubject<EditTaskState>
    private let editTaskUseCase: EditTaskUseCase
    
    // MARK: - Initialize
    
    init(editTaskUseCase: EditTaskUseCase, selfInfo: Employee, editTask: Task?) {
        self.editTaskUseCase = editTaskUseCase
        if let editTask = editTask {
            stateSubject = .init(value: .edit(editTask))
        } else {
            stateSubject = .init(value: .create(selfInfo))
        }
    }
    
    func applyTask(_ mode: EditTaskModel) {
        
    }
    
}
