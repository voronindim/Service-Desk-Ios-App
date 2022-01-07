//
//  EditTaskViewModel.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 21.11.2021.
//

import Foundation
import RxSwift

final class EditTaskViewModel {
    
    // MARK: - Public Properties
    
    var disableApplyButton: Observable<Bool> {
        disableApplyButtonSubject
    }
    
    var successApply: Observable<Bool> {
        appModel.successEdit
    }
    
    var mode: EditTaskViewMode?
    
    private(set) var currentTask: EditTaskViewState?
    
    // MARK: - Private Properties
    
    private let appModel: EditTaskAppModel
    private let disableApplyButtonSubject = BehaviorSubject<Bool>(value: true)
    private let disposeBag = DisposeBag()
    private var startTaskValues: EditTaskViewState?
    
    // MARK: - Initialize
    
    init(appModel: EditTaskAppModel) {
        self.appModel = appModel
        subscribeOnAppModel()
    }
    
    
    // MARK: - Public Methods
    
    func applyChanges() {
        guard let currentTask = currentTask else { return }
        let editTaskModel = EditTaskModel(currentTask)
        appModel.applyTask(editTaskModel)
        updateApplyButton()
    }
    
    func titleDidChanged(_ text: String) {
        currentTask?.title = text
        updateApplyButton()
    }

    func endDateDidChaged(_ date: Date) {
        currentTask?.endDate = date
        updateApplyButton()
    }
    
    func descriptionDidChanged(_ text: String) {
        currentTask?.description = text
        updateApplyButton()
    }
    
    func assignedDidChanged(_ selectionItem: SelectionItem) {
        switch selectionItem {
        case .folders(let array):
            guard let departament = array.first else { return }
            currentTask?.assigned = nil
            currentTask?.departament = departament
        case .employees(let array):
            guard let employee = array.first else { return }
            currentTask?.assigned = employee
        }
        updateApplyButton()
    }
    
    // MARK: - Private Methods
    
    private func subscribeOnAppModel() {
        appModel.state.subscribe(onNext: { [weak self] in
            self?.updateViewState($0)
        }).disposed(by: disposeBag)
    }
    
    private func updateViewState(_ state: EditTaskState) {
        switch state {
        case .edit(let task):
            let editTaskViewState = EditTaskViewState(model: task)
            currentTask = editTaskViewState
            startTaskValues = editTaskViewState
            mode = .edit
        case .create(let selfInfo):
            currentTask = EditTaskViewState(creator: selfInfo)
            mode = .create
        }
    }
    
    private func updateApplyButton() {
        disableApplyButtonSubject.onNext(startTaskValues == currentTask)
    }
    
}

fileprivate extension EditTaskModel {
    init(_ model: EditTaskViewState) {
        self.init(
            id: model.id,
            title: model.title,
            description: model.description,
            endDate: model.endDate,
            creator: model.creator,
            assigned: model.assigned,
            departament: model.departament
        )
    }
}
