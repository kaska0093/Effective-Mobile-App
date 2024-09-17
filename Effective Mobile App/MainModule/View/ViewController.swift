//
//  ViewController.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 31.08.2024.
//

import UIKit



extension ViewController: MainViewInput {
    
    func updateUI() {
        self.tableView.reloadData()
        segmentedControlSetup()
    }
    
    func showErrorMessage(_ message: String) {
        //
    }  
}

class ViewController: UIViewController {
    var presenter: MainViewOutput?


    override func viewWillAppear(_ animated: Bool) {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        
        if !hasLaunchedBefore {
                presenter?.presenterAddToDoFromNetwork()
        } else {
             presenter?.viewWillAppear()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .viewTable
        setupView()
        addConstraints()
    }
    
    @objc func addNewTask() {
        presenter?.addTodo()
    }
    
 
    lazy var lable: UILabel = {
        
        let label = UILabel()
        let attributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        let attributedString = NSAttributedString(string: "Today's Task \(getCurrentDay())",
                                                  attributes: attributes)
        label.attributedText = attributedString
        label.textAlignment = .center
        label.backgroundColor = .viewTable
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

        tableView.backgroundColor = .viewTable
        tableView.separatorColor = .viewTable
        tableView.layer.cornerRadius = 10
        tableView.layer.borderColor = UIColor.viewTable.cgColor
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonAdd
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addNewTask), for: .touchUpInside)
        button.setTitle("+ New Task", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
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
        guard let taskSummary = presenter?.getTasksCountByType() else {
            return UISegmentedControl()
        }
        let segmentedControl = UISegmentedControl(items: ["All (\(taskSummary.common))",
                                                          "Closed (\(taskSummary.complete))",
                                                          "Open (\(taskSummary.incomplete))"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        segmentedControl.backgroundColor = .clear
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    

    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    func segmentedControlSetup() {
        guard let taskSummary = presenter?.getTasksCountByType() else {
            return
        }    
        filterSegmentedContoll.setTitle("All (\(taskSummary.common))", forSegmentAt: 0)
        filterSegmentedContoll.setTitle("Closed (\(taskSummary.complete))", forSegmentAt: 1)
        filterSegmentedContoll.setTitle("Open (\(taskSummary.incomplete))", forSegmentAt: 2)
    }

    
    func setupView() {
        navigationItem.titleView?.frame.size.height = 5
        
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
            filterSegmentedContoll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),

            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: filterSegmentedContoll.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

