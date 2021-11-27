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
    
    @IBOutlet private var taskTitleLabel: UILabel!
    @IBOutlet private var taskTitleInputField: UITextField!
    
    @IBOutlet private var assignedTitleLabel: UILabel!
    @IBOutlet private var assignedStaskView: UIStackView!
    @IBOutlet private var assignedUserAvatarImageView: UIImageView!
    @IBOutlet private var assignedUserNameLabel: UILabel!
    
    @IBOutlet private var endDateLabel: UILabel!
    @IBOutlet private var endDatePicker: UIDatePicker!
    
    @IBOutlet private var decsriptionTitleLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    
    
    // MARK: - Public Properties
    
    var viewModel: EditTaskViewModel?
    var closeHandler: (() -> Void)?
    
    // MARK: - Private Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        descriptionTextViewAddContentInsets()
        addActionOnTextField()
        addActionEndDatePicker()
        addActionOnTapAssignedUser()
        
        taskTitleInputField.delegate = self
        descriptionTextView.delegate = self
        
        subscribeOnViewModel()
        subscribeOnNotificationCenter()
        
        setupNavigationBar()
        setupEndDatePicker()
        setupViewData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
    
    private func setupEndDatePicker() {
        endDatePicker.datePickerMode = .date
        endDatePicker.preferredDatePickerStyle = .compact
    }
    
    @objc private func leftNavigationBarButtonDidTapped() {
        closeHandler?()
    }
    
    @objc private func rightNavigationBarButtonDidTapped() {
        viewModel?.applyChanges()
        closeHandler?()
    }
    
    private func addActionOnTapAssignedUser() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(assignedUserDidTapped))
        assignedStaskView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func assignedUserDidTapped() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    private func addActionOnTextField() {
        taskTitleInputField.addTarget(self, action: #selector(titleInputFieldDidChanged(_:)), for: .editingChanged)
    }
    
    @objc private func titleInputFieldDidChanged(_ textField: UITextField) {
        viewModel?.titleDidChanged(textField.text ?? "")
    }
    
    private func addActionEndDatePicker() {
        endDatePicker.addTarget(self, action: #selector(endDateDidChanged), for: .valueChanged)
    }
    
    @objc private func endDateDidChanged() {
        viewModel?.endDateDidChaged(endDatePicker.date)
    }
    
    private func subscribeOnViewModel() {
        viewModel?.viewState.subscribe(onNext: { [weak self] state in
            self?.updateView(state)
        }).disposed(by: disposeBag)
        
        viewModel?.disableApplyButton.subscribe(onNext: { [weak self] isDisable in
            self?.setupApplyButton(isDisable)
        }).disposed(by: disposeBag)
    }
    
    private func descriptionTextViewAddContentInsets() {
        descriptionTextView.textContainerInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
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
    
    private func subscribeOnNotificationCenter() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            descriptionTextView.contentInset = .zero
        } else {
            descriptionTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        descriptionTextView.scrollIndicatorInsets = descriptionTextView.contentInset

        let selectedRange = descriptionTextView.selectedRange
        descriptionTextView.scrollRangeToVisible(selectedRange)
    }
    
}

// MARK: - UITextFieldDelegate

extension EditTaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITextViewDelegate

extension EditTaskViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.descriptionDidChanged(textView.text)
    }
}


// MARK: - InstntiateFromStoryboard

extension EditTaskViewController: InstantiateFromStoryboard {
    static let storyboardName = "EditTaskViewController"
}
