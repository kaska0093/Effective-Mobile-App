//
//  ViewControllerDataSource.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 04.09.2024.
//

import UIKit


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filterSegmentedContoll.selectedSegmentIndex == 0 {
            return presenter?.getNumberOfTasks(indexOfSection: 0) ?? 0
        } else if filterSegmentedContoll.selectedSegmentIndex == 1 {
            return presenter?.getNumberOfTasks(indexOfSection: 1) ?? 0
        } else {
            return presenter?.getNumberOfTasks(indexOfSection: 2) ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .viewTable
        
        if filterSegmentedContoll.selectedSegmentIndex == 0 {
            guard let task = presenter?.getTaskAt(indexOfCell: indexPath.row, indexOfSection: 0) else {
                return UITableViewCell()
            }
            cell.configure(with: task)
        } else if filterSegmentedContoll.selectedSegmentIndex == 1 {
            guard let task = presenter?.getTaskAt(indexOfCell: indexPath.row, indexOfSection: 1) else {
                return UITableViewCell()
            }
            cell.configure(with: task)
        } else {
            guard let task = presenter?.getTaskAt(indexOfCell: indexPath.row, indexOfSection: 2) else {
                return UITableViewCell()
            }
            cell.configure(with: task)
        }
        cell.delegate = self
        return cell
    }  
}
