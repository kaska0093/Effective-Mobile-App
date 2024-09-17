//
//  AddNewTaskViewController.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 04.09.2024.
//

import UIKit

class AddViewController: UIViewController {
    
    var presenter: AddViewOutput?
    var keyForAdd: Bool?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewTable

        setupViews()
        setupConstrains()
    }
    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 26, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        let attributedString = NSAttributedString(string: "Task Name",
                                                  attributes: attributes)
        label.attributedText = attributedString

        return label
    }()
    
    lazy var taskMameTextField: UITextField = {
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter task name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var dueOnLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 26, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        let attributedString = NSAttributedString(string: "Due on",
                                                  attributes: attributes)
        label.attributedText = attributedString

        return label
    }()
    
    lazy var dueONDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.minimumDate = Date()
        datePicker.datePickerMode = .dateAndTime
        return datePicker
    }()
    
    
    private func setupViews() {
        
        if keyForAdd! {
            title = "Add new Task"

        } else {
            title = "Edit Task"
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveTask))

        
        [taskNameLabel, taskMameTextField, dueOnLabel, dueONDatePicker].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            taskNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            taskMameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 8),
            taskMameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            taskMameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            dueOnLabel.topAnchor.constraint(equalTo: taskMameTextField.bottomAnchor, constant: 20),
            dueOnLabel.leadingAnchor.constraint(equalTo: taskMameTextField.leadingAnchor),
            
            dueONDatePicker.topAnchor.constraint(equalTo: taskMameTextField.bottomAnchor, constant: 8),
            dueONDatePicker.trailingAnchor.constraint(equalTo: taskMameTextField.trailingAnchor)
        ])
    }
        
    @objc func saveTask() {
        
        guard let taskName = taskMameTextField.text, !taskName.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Task is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let dueOn = dueONDatePicker.date
        
        if keyForAdd! {
            presenter?.userPressedAddButton(taskName: taskName, dueOn: dueOn)
        } else {
            title = "Edit Task"
            presenter?.userPressedUpdateButton(taskName: taskName, dueOn: dueOn)
        }
    }
    
}
extension AddViewController: AddViewInput {
    
    func updateUI(task:String, dueOn: Date) {
        taskMameTextField.text = task
        dueONDatePicker.date = dueOn
    }
    
    
}

