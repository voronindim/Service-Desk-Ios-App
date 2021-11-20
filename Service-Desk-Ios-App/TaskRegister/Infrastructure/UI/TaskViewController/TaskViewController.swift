//
//  TaskViewController.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 14.11.2021.
//

import UIKit
import RxSwift
import Lottie

class TaskViewController: UIViewController {

    // MARK: - Public Proeprties
    
    var coordinator: Coordinator?
    var viewModel: TaskViewModel?
    
    // MARK: - Private Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 8
        return tableView
    }()
    
    private let loadingAnimationView = AnimationView()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        registerCells()
        setupTableView()
        setupAnimationView()
        setupNavigationBar()
        subscribeOnViewModel()
        setupRefreshControl()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        setConstraints()
    }
    
    private func setupAnimationView() {
        loadingAnimationView.animation = Animation.named("loading-indicator")
        loadingAnimationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        loadingAnimationView.center = view.center
        loadingAnimationView.contentMode = .scaleAspectFit
        loadingAnimationView.loopMode = .loop
        view.addSubview(loadingAnimationView)
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
            startLoadingAnimationView()
            tableView.isHidden = true
        case .loaded:
            endRefreshing()
            stopLoadingAnimationView()
            tableView.reloadData()
            tableView.isHidden = false
        case .error(let viewErrorType):
            stopLoadingAnimationView()
            endRefreshing()
            if viewModel?.currentTask == nil {
                tableView.isHidden = true
            } else {
                InfoToast.show("\(viewErrorType)", image: UIImage(systemName: "wifi.exclamationmark"))
            }
        }
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(willRefreshHandler), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc private func willRefreshHandler() {
        viewModel?.refresh()
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
        tableView.refreshControl?.endRefreshing()
    }
    
    private func setupNavigationBar() {
        title = "Поручение"
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: StatusTableViewCell.reuseIdentifier, bundle: Bundle(for: StatusTableViewCell.self)), forCellReuseIdentifier: StatusTableViewCell.reuseIdentifier)
        
        tableView.register(UINib(nibName: TitleAndEndDateTableViewCell.reuseIdentifier, bundle: Bundle(for: TitleAndEndDateTableViewCell.self)), forCellReuseIdentifier: TitleAndEndDateTableViewCell.reuseIdentifier)
        
        tableView.register(UINib(nibName: UserTableTableViewCell.reuseIdentifier, bundle: Bundle(for: UserTableTableViewCell.self)), forCellReuseIdentifier: UserTableTableViewCell.reuseIdentifier)
        
        tableView.register(UINib(nibName: DescriptionTableViewCell.reuseIdentifier, bundle: Bundle(for: DescriptionTableViewCell.self)), forCellReuseIdentifier: DescriptionTableViewCell.reuseIdentifier)
    }
    
    private func showAlertWithTaskStates() {
        let alert = UIAlertController()
        
        let closedWithColor = taskStatusToStringWithColor(.closed)
        let closedAction = UIAlertAction(title: closedWithColor.text + " \u{263A}", style: .default, handler: { [weak self] _ in
            self?.viewModel?.statusDidChanges(.closed, completion: {
                self?.tableView.reloadSections([0], with: .automatic)
            })
        })
        closedAction.setValue(closedWithColor.color, forKey: "titleTextColor")
        alert.addAction(closedAction)
        
        let reviewWithColor = taskStatusToStringWithColor(.review)
        let reviewAction = UIAlertAction(title: reviewWithColor.text + " \u{1F974}", style: .default, handler: { [weak self] _ in
            self?.viewModel?.statusDidChanges(.review, completion: {
                self?.tableView.reloadSections([0], with: .automatic)
            })
        })
        reviewAction.setValue(reviewWithColor.color, forKey: "titleTextColor")
        alert.addAction(reviewAction)
        
        let inProgressWithColor = taskStatusToStringWithColor(.inProgress)
        let isProgressAction = UIAlertAction(title: inProgressWithColor.text + " \u{1F913}", style: .default, handler: { [weak self] _ in
            self?.viewModel?.statusDidChanges(.inProgress, completion: {
                self?.tableView.reloadSections([0], with: .automatic)
            })
        })
        isProgressAction.setValue(inProgressWithColor.color, forKey: "titleTextColor")
        alert.addAction(isProgressAction)
        
        let notStartedWithColor = taskStatusToStringWithColor(.notStarted)
        let notStartedAction = UIAlertAction(title: notStartedWithColor.text + " \u{1F975}", style: .default, handler: { [weak self] _ in
            self?.viewModel?.statusDidChanges(.notStarted, completion: {
                self?.tableView.reloadSections([0], with: .automatic)
            })
        })
        notStartedAction.setValue(notStartedWithColor.color, forKey: "titleTextColor")
        alert.addAction(notStartedAction)

        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel)
        cancelAlert.setValue(UIColor.systemRed, forKey: "titleTextColor")
        
        alert.addAction(cancelAlert)
        
        present(alert, animated: true)
    }
}


extension TaskViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        indexPath.section == 0 || indexPath.section == 3 ? indexPath : nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            showAlertWithTaskStates()
        case 3:
            // TODO: окткрыть экран с выбором человека
            break
        default:
            assertionFailure("Пользователь выбрал ячейку, которая не кликабельная, нужно убрать возможность выделения")
            return
        }
    }
}

extension TaskViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let task = viewModel?.currentTask else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: StatusTableViewCell.reuseIdentifier, for: indexPath) as! StatusTableViewCell
            cell.setViewState(status: task.status)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleAndEndDateTableViewCell.reuseIdentifier, for: indexPath) as! TitleAndEndDateTableViewCell
            cell.setViewState(TitleAndEndDateTableViewCell.Model(title: task.title, endDate: task.endDate))
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableTableViewCell.reuseIdentifier, for: indexPath) as! UserTableTableViewCell
            cell.setiViewState(UserTableTableViewCell.Model(userName: task.creator.name, avatarUrl: task.creator.avatarUrl))
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableTableViewCell.reuseIdentifier, for: indexPath) as! UserTableTableViewCell
            cell.setiViewState(UserTableTableViewCell.Model(userName: task.assigned.name, avatarUrl: task.assigned.avatarUrl))
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.reuseIdentifier, for: indexPath) as! DescriptionTableViewCell
            cell.setViewState(DescriptionTableViewCell.Model(description: task.description))
            return cell
        default:
            assertionFailure("Произошло обращение к несуществуещей секции, не знаю какую ячейку создать в таблицу")
            return UITableViewCell()
        }
    }
    
    // TODO: убрать после проверки
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 2:
            return "От кого:"
        case 3:
            return "Кому:"
        case 4:
            return "Описание"
        default:
            return nil
        }
        
    }
    
    
}
