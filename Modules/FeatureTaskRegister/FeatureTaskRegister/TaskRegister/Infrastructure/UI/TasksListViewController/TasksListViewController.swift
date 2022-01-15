//
//  TasksListViewController.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import UIKit
import RxSwift
import Lottie

enum SelectType {
    case onMe
    case fromMe
}

class TasksListViewController: UIViewController {

    // MARK: - Public Properties
    
    var viewModel: TasksListViewModel?
    var coordinator: Coordinator?
    var filterHandler: ((UINavigationController, @escaping (SelectionItem) -> Void) -> Void)?
    
    // MARK: - Private Properties
    
    private let tasksListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let loadingAnimationView = AnimationView()
    private let disposeBag = DisposeBag()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        registerCells()
        setupNavigationBar()
        setup()
        setupAnimationView()
        setupSearchController()
        setupRefreshControl()
        subscribeOnViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.reloadTasksList()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        let rightNavigationBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(rightNavigationBarButtonDidTapped))
        navigationItem.rightBarButtonItem = rightNavigationBarButton
        
        let leftNavigationBarButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(leftNavigattionBarButtonDidTaped))
        navigationItem.leftBarButtonItem = leftNavigationBarButton
    }
    
    @objc private func leftNavigattionBarButtonDidTaped() {
        let alert = UIAlertController(title: nil, message: "Какие задачи вы хотите видеть?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "На мне", style: .default, handler: { [weak self] _ in
            self?.viewModel?.tasksListOnMe()
        }))
        
        alert.addAction(UIAlertAction(title: "От меня", style: .default, handler: { [weak self] _ in
            self?.viewModel?.tasksListFromMe()
        }))
        
        alert.addAction(UIAlertAction(title: "Выбрать", style: .default, handler: { [weak self] _ in
            self?.showCustomSelect()
        }))
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showCustomSelect() {
        guard let navigationController = navigationController else { return }
        filterHandler?(navigationController) { [weak self] selectionItem in
            self?.viewModel?.filterDidChnaged(selectionItem)
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func setupAnimationView() {
        loadingAnimationView.animation = Animation.named("loading-indicator", bundle: Bundle(for: TasksListViewController.self))
        loadingAnimationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        loadingAnimationView.center = view.center
        loadingAnimationView.contentMode = .scaleAspectFit
        loadingAnimationView.loopMode = .loop
        view.addSubview(loadingAnimationView)
    }
    
    @objc private func rightNavigationBarButtonDidTapped() {
        coordinator?.showEditViewController(task: nil)
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlHandler), for: .valueChanged)
        tasksListTableView.refreshControl = refreshControl
    }
    
    @objc private func refreshControlHandler() {
        viewModel?.reloadTasksList()
    }
    
    private func selectButton(type: SelectType) {
        switch type {
        case .onMe:
            viewModel?.tasksListOnMe()
        case .fromMe:
            viewModel?.tasksListFromMe()
        }
    }
    
    private func setup() {
        tasksListTableView.delegate = self
        tasksListTableView.dataSource = self
        view.addSubview(tasksListTableView)
        
        setConstraints()
        
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
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
            startLoadingAnimationView()
            tasksListTableView.isHidden = true
        case .loaded:
            endRefreshing()
            stopLoadingAnimationView()
            tasksListTableView.reloadData()
            tasksListTableView.isHidden = false
        case .error(let viewErrorType):
            stopLoadingAnimationView()
            endRefreshing()
            if viewModel?.currentViewItems == nil {
                tasksListTableView.isHidden = true
            } else {
                InfoToast.show("\(viewErrorType)", image: UIImage(systemName: "wifi.exclamationmark"))
            }
        }
    }
    
    func registerCells() {
        tasksListTableView.register(UINib(nibName: TasksListTableViewCell.reuseIdentidier, bundle: Bundle(for: TasksListTableViewCell.self)), forCellReuseIdentifier: TasksListTableViewCell.reuseIdentidier)
    }
    
    private func startLoadingAnimationView() {
        loadingAnimationView.isHidden = false
        loadingAnimationView.play()
    }
    
    private func stopLoadingAnimationView() {
        loadingAnimationView.isHidden = true
        loadingAnimationView.stop()
    }
    
    private func endRefreshing() {
        tasksListTableView.refreshControl?.endRefreshing()
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

// MARK: - UISearchResultsUpdating

extension TasksListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.filterTextDidChanged(searchController.searchBar.text ?? "")
    }
}
