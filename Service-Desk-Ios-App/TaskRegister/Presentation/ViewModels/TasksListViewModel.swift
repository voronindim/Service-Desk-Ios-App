//
//  TasksListViewModel.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 13.11.2021.
//

import Foundation
import RxSwift

final class TasksListViewModel {
    
    // MARK: - Public Properties
    
    var viewState: Observable<ViewState> {
        viewStateSubject
    }
    
    private(set) var currentViewItems: [TasksListItemViewState]?
    
    // MARK: - Private Properties
    
    private let appModel: TasksListAppModel
    private let disposeBag = DisposeBag()
    private let viewStateSubject = PublishSubject<ViewState>()
    
    // MARK: - Initialize
    
    init(appModel: TasksListAppModel) {
        self.appModel = appModel
        subsribeOnAppModel()
    }
    
    // MARK: - Public Methods
    
    func reloadTasksList() {
        appModel.reloadTasksList()
    }
    
    // MARK: - Private Methods
    
    private func subsribeOnAppModel() {
        appModel.state.subscribe(onNext: {
            self.updateViewState($0)
        }).disposed(by: disposeBag)
    }
    
    private func updateViewState(_ state: TasksListAppState) {
        switch state {
        case .loading:
            viewStateSubject.onNext(.loading)
        case .loaded(let tasks):
            currentViewItems = tasks.map({ TasksListItemViewState(model: $0) })
            viewStateSubject.onNext(.loaded)
        case .error(let useCasesError):
            let viewErrorType = ViewErrorType(useCaseError: useCasesError)
            viewStateSubject.onNext(.error(viewErrorType))
        }
    }
}
