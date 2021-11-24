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
        
        taskTitleInputField.delegate = self
        descriptionTextView.delegate = self
        
        setupNavigationBar()
        subscribeOnViewModel()
        setupViewData()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        title = viewModel?.mode == .edit ? "Редактирование" : "Создание"
        
        let leftNavigationBarButton = UIBarButtonItem(image: UIImage(systemName: "xmark.circle.fill"), style: .plain, target: self, action: #selector(leftNavigationBarButtonDidTapped))
        navigationItem.leftBarButtonItem = leftNavigationBarButton
    }
    
    private func setupApplyButton(_ disable: Bool) {
        let image = disable ?
            UIImage(systemName: "arrowshape.turn.up.forward.circle.fill") :
            UIImage(systemName: "arrowshape.turn.up.forward.circle")
        
        let rightNavigationvBarButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(rightNavigationBarButtonDidTapped))
        rightNavigationvBarButton.isEnabled = !disable
        navigationItem.rightBarButtonItem = rightNavigationvBarButton
    }
    
    
    @objc private func leftNavigationBarButtonDidTapped() {
        closeHandler?()
    }
    
    @objc private func rightNavigationBarButtonDidTapped() {
        viewModel?.applyChanges()
        closeHandler?()
    }
    
    private func subscribeOnViewModel() {
        viewModel?.viewState.subscribe(onNext: { [weak self] state in
            self?.updateView(state)
        }).disposed(by: disposeBag)
        
        viewModel?.disableApplyButton.subscribe(onNext: { [weak self] isDisable in
            self?.setupApplyButton(isDisable)
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

// MARK: - UITextFieldDelegate

extension EditTaskViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case taskTitleInputField:
            viewModel?.titleDidChanged(textField.text ?? "")
        case endDateInputField:
            break
        default:
            assertionFailure("изменение поля без делегата")
            return
        }
    }
}

// MARK: - UITextViewDelegate

extension EditTaskViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.descriptionDidChanged(textView.text)
    }
}


// MARK: - InstntiateFromStoryboard

extension EditTaskViewController: InstantiateFromStoryboard {
    static let storyboardName = "EditTaskViewController"
}
