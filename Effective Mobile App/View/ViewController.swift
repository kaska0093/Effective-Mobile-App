//
//  ViewController.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 31.08.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = TaskListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
      // navigationController?.navigationBar.prefersLargeTitles = true
      //  navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        setupView()
        addConstraints()

        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if !hasLaunchedBefore {
            Task {
                do {
                    let result = try await NetworkManager.shared.fetchData()
                    for i in 0..<result.todos.count {
                        CoreDataManager.shared.addNewTask(taskName: result.todos[i].todo,
                                                          dueOn: Date.now)
                    }
                    self.viewModel = TaskListViewModel()
                    self.viewModel.getAll()
                    tableView.reloadData()
                    UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                } catch {
                    
                }
            }
        } else {
            self.viewModel = TaskListViewModel()
            self.viewModel.getAll()
            tableView.reloadData()
        }
    }
    @objc func addNewTask() {
        navigationController?.pushViewController(AddNewTaskViewController(), animated: true)
        print("add VC")
    }
    

    
    lazy var lable: UILabel = {
        let label = UILabel()
        label.text = "Today's Task \(getCurrentDay())"
        label.textAlignment = .center
        label.backgroundColor = .green
        label.numberOfLines = 0
        return label
    }()
    
    func getCurrentDay() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE, d MMMM"
        let formattedDate = dateFormatter.string(from: currentDate)
        return(formattedDate)
    }
    
    lazy var tableView: UITableView = {

        let tableView = UITableView()

        tableView.backgroundColor = .lightGray
    //  tableView.separatorColor = .red
    //  tableView.separatorStyle = .singleLine
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.red.cgColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
       // button.setImage(.add, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        button.setTitle("+ New Task", for: .normal)
        return button
    }()
    
    lazy var notificationLabel: UILabel = {
        let notificationLabel = UILabel()
        notificationLabel.textColor = .white
        notificationLabel.backgroundColor = .red
        notificationLabel.textAlignment = .center
        notificationLabel.layer.cornerRadius = 8
        notificationLabel.layer.masksToBounds = true
        return notificationLabel
    }()
    
    lazy var filterSegmentedContoll: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["All", "Opened", "Closed"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    

    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // здесь обрабатываем изменение выбранного сегмента
        let selectedIndex = sender.selectedSegmentIndex
        print("Selected segment index: \(selectedIndex)")
        tableView.reloadData()
        getCountTasksByType()
    }
    
    func getCountTasksByType() {
        let taskSummary = viewModel.getTasksByType()
        print(taskSummary.complete.description)
        print(taskSummary.incomplete.description)
    }

    
    func setupView() {
        [lable, addButton, tableView, filterSegmentedContoll].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
    }
    
    

    
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            
            lable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            lable.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -40),
            
            filterSegmentedContoll.topAnchor.constraint(equalTo: lable.bottomAnchor, constant: 10),
            filterSegmentedContoll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            filterSegmentedContoll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),


            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: filterSegmentedContoll.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        print("SegmentedControl frame: \(filterSegmentedContoll.frame)")
        print("SegmentedControl superview: \(filterSegmentedContoll.superview?.description ?? "nil")")


    }


}

