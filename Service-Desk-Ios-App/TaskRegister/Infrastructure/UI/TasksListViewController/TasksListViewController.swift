//
//  TasksListViewController.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import UIKit
import RxSwift

class TasksListViewController: UIViewController {

    // MARK: - Public Properties
    
    var viewModel: TasksListViewModel?
    var coordinator: Coordinator?
    
    // MARK: - Private Properties
    
    private let tasksListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupNavigationBar()
        setup()
        setupRefreshControl()
        subscribeOnViewModel()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        let rightNavigationBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(rightNavigationBarButtonDidTapped))
        navigationItem.rightBarButtonItem = rightNavigationBarButton
    }
    
    @objc private func rightNavigationBarButtonDidTapped() {
        
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlHandler), for: .valueChanged)
    }
    
    @objc private func refreshControlHandler() {
        viewModel?.reloadTasksList()
    }
    
    private func setup() {
        tasksListTableView.delegate = self
        tasksListTableView.dataSource = self
        view.addSubview(tasksListTableView)
        setConstraints()
    }
    
    private func setConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(tasksListTableView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(tasksListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        constraints.append(tasksListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        constraints.append(tasksListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }

    private func subscribeOnViewModel() {
        viewModel?.viewState.subscribe(onNext: { [weak self] state in
            self?.updateViewState(state)
        }).disposed(by: disposeBag)
    }
    
    private func updateViewState(_ state: ViewState) {
        tasksListTableView.refreshControl?.endRefreshing()
        switch state {
        case .loading:
            break
        case .loaded:
            tasksListTableView.reloadData()
        case .error(_):
            break
        }
    }
    
    func registerCells() {
        tasksListTableView.register(UINib(nibName: TasksListTableViewCell.reuseIdentidier, bundle: Bundle(for: TasksListTableViewCell.self)), forCellReuseIdentifier: TasksListTableViewCell.reuseIdentidier)
    }
    
}

// MARK: - UITableViewDelegate

extension TasksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let taskId = viewModel?.currentViewItems?[indexPath.row].id {
            coordinator?.showTaskViewController(taskId: taskId)
        } else {
            // TODO: Показать сообщение о том, что не получилось открыть это поручение.
        }
    }
}

// MARK: - UITableViewDataSource

extension TasksListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.currentViewItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksListTableViewCell.reuseIdentidier, for: indexPath) as! TasksListTableViewCell
        if let viewState = viewModel?.currentViewItems?[indexPath.row] {
            cell.setViewState(viewState)
        }
        return cell
    }
    
    
}

