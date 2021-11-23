//
//  EditTaskViewController.swift
//  Service-Desk-Ios-App
//
//  Created by Dmitrii Voronin on 21.11.2021.
//

import UIKit
import RxSwift

class EditTaskViewController: UIViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskTitleInputField: UITextField!
    @IBOutlet var assignedTitleLabel: UILabel!
    @IBOutlet var assignedStaskView: UIStackView!
    @IBOutlet var assignedUserAvatarImageView: UIImageView!
    @IBOutlet var assignedUserNameLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var endDateInputField: UITextField!
    @IBOutlet var decsriptionTitleLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    
    
    // MARK: - Public Properties
    
    var viewModel: EditTaskViewModel?
    var closeHandler: (() -> Void)?
    
    // MARK: - Private Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        subscribeOnViewModel()
        setupViewData()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        title = "Редактирование"
        let leftNavigationBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle.fill"), style: .done, target: self, action: #selector(leftNavigationBarButtonDidTapped))
        navigationItem.leftBarButtonItem = leftNavigationBarButton
    }
    
    @objc private func leftNavigationBarButtonDidTapped() {
        closeHandler?()
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
    
    private func setupViewData() {
        guard let viewModel = viewModel else { return }
        guard let task = viewModel.currentTask else { return }
        taskTitleInputField.text = task.title
        assignedUserNameLabel.text = task.assigned?.name
        descriptionTextView.text = task.description
    }
    
    
}


// MARK: - InstntiateFromStoryboard

extension EditTaskViewController: InstantiateFromStoryboard {
    static let storyboardName = "EditTaskViewController"
}
