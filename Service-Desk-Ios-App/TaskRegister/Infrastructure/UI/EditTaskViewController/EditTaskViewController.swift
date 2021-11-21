//
//  EditTaskViewController.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 21.11.2021.
//

import UIKit
import RxSwift

class EditTaskViewController: UIViewController {

    // MARK: - Public Properties
    
    var coordinator: Coordinator?
    var viewModel: EditTaskViewModel?
    
    // MARK: - Private Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 8
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        subscribeOnViewModel()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        title = "Редактирование"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setConstraints()
    }
    
    private func setConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(tableView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func subscribeOnViewModel() {
        self.viewModel?.viewState.subscribe(onNext: { [weak self] state in
            self?.updateView(state)
        }).disposed(by: disposeBag)
    }
    
    private func updateView(_ state: ViewState) {
        switch state {
        case .loading:
            break
        case .loaded:
            break
        case .error(_):
            break
        }
    }
}

// MARK: - UITableViewDelegate

extension EditTaskViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension EditTaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}
