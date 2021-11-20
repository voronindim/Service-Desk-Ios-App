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
    
    private(set) var currentViewItems: [TasksListItemViewState]? {
        didSet {
            viewStateSubject.onNext(.loaded)
        }
    }
    
    // MARK: - Private Properties
    
    private let appModel: TasksListAppModel
    private let disposeBag = DisposeBag()
    private let viewStateSubject = BehaviorSubject<ViewState>(value: .loading)
    
    private var items: [TasksListItemViewState]?
    private var filterText: String = "" {
        didSet {
            updateCurrentViewItems()
        }
    }
    
    // MARK: - Initialize
    
    init(appModel: TasksListAppModel) {
        self.appModel = appModel
        subsribeOnAppModel()
    }
    
    // MARK: - Public Methods
    
    func filterTextDidChanged(_ text: String) {
        filterText = text
    }
    
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
            items = tasks.map({ TasksListItemViewState(model: $0) })
            updateCurrentViewItems()
        case .error(let useCasesError):
            let viewErrorType = ViewErrorType(useCaseError: useCasesError)
            viewStateSubject.onNext(.error(viewErrorType))
        }
    }
    
    private func updateCurrentViewItems() {
        currentViewItems = items?.filter({ item in
            let filterTextLowercase = filterText.lowercased()
            guard !filterText.isEmpty else { return true }
            guard !item.title.lowercased().contains(filterTextLowercase) else { return true }
            guard !item.creator.name.contains(filterTextLowercase) else { return true }
            return false
        })
    }
}
