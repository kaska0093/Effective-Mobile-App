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
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonAdd
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        if keyForAdd! {
            button.setTitle("Save", for: .normal)
        } else {
            button.setTitle("Update", for: .normal)
        }
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    lazy var returnButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonAdd
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(exit), for: .touchUpInside)
        button.setTitle("Exit", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    @objc func exit() {
        presenter?.userPressedExit()
    }
    
    lazy var taskNameLabel: UILabel = {
        let label = UILabel()

        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 26, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        let attributedString = NSAttributedString(string: "Task:",
                                                  attributes: attributes)
        label.attributedText = attributedString

        return label
    }()
    
    lazy var taskMameTextField: UITextView = {
        
        let textView = UITextView()
        //textField.placeholder = "Enter task name"
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.layer.cornerRadius = 25
        textView.clipsToBounds = true
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        //textView.isScrollEnabled = true
        textView.sizeToFit()
        textView.frame.size.height = textView.contentSize.height


        return textView
    }()
    
    lazy var dueOnLabel: UILabel = {
        
        let label = UILabel()

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

        
        [taskNameLabel, taskMameTextField, dueOnLabel, dueONDatePicker,addButton,returnButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
    }
    
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            
            addButton.widthAnchor.constraint(equalToConstant: 100),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            returnButton.widthAnchor.constraint(equalToConstant: 100),
            returnButton.heightAnchor.constraint(equalToConstant: 30),
            returnButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            taskNameLabel.topAnchor.constraint(equalTo: returnButton.bottomAnchor, constant: 50),
            taskNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            taskMameTextField.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: 8),
            taskMameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            taskMameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            taskMameTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 130),

            
            dueOnLabel.topAnchor.constraint(equalTo: taskMameTextField.bottomAnchor, constant: 20),
            dueOnLabel.leadingAnchor.constraint(equalTo: taskMameTextField.leadingAnchor),
            
            dueONDatePicker.topAnchor.constraint(equalTo: dueOnLabel.topAnchor),
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

