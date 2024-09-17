//
//  ViewControllerDelegate.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 04.09.2024.
//

import UIKit

extension ViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, complitionHandler) in
            self?.presenter?.removeTodo(indexOfCell: indexPath.row,
                                        indexOfSection: self?.filterSegmentedContoll.selectedSegmentIndex ?? 0)
            complitionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, complitionHandler) in
            self?.presenter?.showTodoDetail(indexOfCell: indexPath.row,
                                            indexOfSection: self?.filterSegmentedContoll.selectedSegmentIndex ?? 0)
            complitionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    
    //        func completeTaskByIndex(at indexPathRow: Int) {
    //            let task = viewModel.currentTask(by: indexPathRow)
    //            viewModel.toogleCompleted(task: task)
    //            tableView.reloadData()
    //        }
    //
    //        func completeTask(task: TaskEntityDTO) {
    //            presenter?.togleTask(task: task)
    //        }
    //    }
}


extension ViewController: CustomCellDelegate {
    
    func didTapButton(in cell: ToDoTableViewCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            presenter?.togleTask(indexOfCell: indexPath.row,
                                 indexOfSection: filterSegmentedContoll.selectedSegmentIndex)
        }
    }
    
//    func getNeedViewModel(indexPath: Int) -> TaskEntityDTO? {
//        var task: TaskEntityDTO?
//        if filterSegmentedContoll.selectedSegmentIndex == 0 {
//            task = todos[indexPath]
//        } else if filterSegmentedContoll.selectedSegmentIndex == 1 {
//            task = todos.filter { $0.copmleted }[indexPath]
//        } else {
//            task = todos.filter { !$0.copmleted }[indexPath]
//        }
//        return task
//    }
}
