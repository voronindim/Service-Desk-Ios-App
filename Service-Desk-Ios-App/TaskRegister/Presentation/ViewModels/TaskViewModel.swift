//
//  TaskViewModel.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 20.11.2021.
//

import Foundation
import RxSwift

final class TaskViewModel {
    
    // MARK: - Public Properties
    
    var viewState: Observable<ViewState> {
        viewStateSubject
    }
    
    private(set) var currentTask: TaskViewState?
    
    // MARK: - Private Properties
    
    private let appModel: TaskAppModel
    private let viewStateSubject = BehaviorSubject<ViewState>(value: .loaded)
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialize
    
    init(appModel: TaskAppModel) {
        self.appModel = appModel
        subcribeOnAppModel()
    }
    
    // MARK: - Public Methods
    
    func statusDidChanges(_ status: TaskStatus, completion: () -> Void) {
        if currentTask?.status != status {
            appModel.statusDidChanges(status)
            currentTask?.status = status
            completion()
        }
    }
    
    func refresh() {
        appModel.reloadDetails()
    }
    
    // MARK: - Private Methods
    
    private func subcribeOnAppModel() {
        appModel.state.subscribe(onNext: {
            self.updateViewState($0)
        }).disposed(by: disposeBag)
    }
    
    private func updateViewState(_ state: TaskAppState) {
        switch state {
        case .loading:
            viewStateSubject.onNext(.loading)
        case .loaded(let task):
            currentTask = TaskViewState(model: task)
            viewStateSubject.onNext(.loaded)
        case .error(let useCasesError):
            let viewErrorType = ViewErrorType(useCaseError: useCasesError)
            viewStateSubject.onNext(.error(viewErrorType))
        }
    }
    
}
