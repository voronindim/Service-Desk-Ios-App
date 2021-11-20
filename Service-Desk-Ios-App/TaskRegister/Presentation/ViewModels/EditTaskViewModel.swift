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
    
    private(set) var currentTask: EditTaskViewState?
    
    // MARK: - Private Properties
    
    private let appModel: EditTaskAppModel
    private let viewStateSubject = BehaviorSubject<ViewState>(value: .loading)
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    
    init(appModel: EditTaskAppModel) {
        self.appModel = appModel
        subscribeOnAppModel()
    }
    
    // MARK: - Public Methods
    
    func titleDidChanged(_ title: String) {
        currentTask?.title = title
        viewStateSubject.onNext(.loaded)
    }
    
    func descriptionDidChanged(_ text: String) {
        currentTask?.description = text
        viewStateSubject.onNext(.loaded)
    }
    
    func endDateDidChanged(_ date: Date) {
        currentTask?.endDate = date
        viewStateSubject.onNext(.loaded)
    }
    
    func assignedDidChanged(_ assigned: Employee) {
        currentTask?.assigned = assigned
        viewStateSubject.onNext(.loaded)
    }
    
    func departamentDidChanged(_ departament: Departament) {
        currentTask?.departament = departament
        viewStateSubject.onNext(.loaded)
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
        case .create(let selfInfo):
            currentTask = EditTaskViewState(creator: selfInfo)
        }
    }
    
}
