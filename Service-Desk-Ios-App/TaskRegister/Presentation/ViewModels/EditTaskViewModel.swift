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
    
    var viewState: Observable<ViewState> {
        viewStateSubject
    }
    
    var disableApplyButton: Observable<Bool> {
        disableApplyButtonSubject
    }
    
    var mode: EditTaskViewMode?
    
    private(set) var currentTask: EditTaskViewState?
    
    // MARK: - Private Properties
    
    private let appModel: EditTaskAppModel
    private let viewStateSubject = BehaviorSubject<ViewState>(value: .loading)
    private let disableApplyButtonSubject = BehaviorSubject<Bool>(value: false)
    private let disposeBag = DisposeBag()
    
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
    }
    
    func titleDidChanged(_ text: String) {
        currentTask?.title = text
    }

    func endDateDidChaged(_ date: Date) {
        currentTask?.endDate = date
    }
    
    func descriptionDidChanged(_ text: String) {
        currentTask?.description = text
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
            currentTask = EditTaskViewState(model: task)
            mode = .edit
        case .create(let selfInfo):
            currentTask = EditTaskViewState(creator: selfInfo)
            mode = .create
        }
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
