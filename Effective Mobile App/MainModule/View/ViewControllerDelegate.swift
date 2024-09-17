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
}


extension ViewController: CustomCellDelegate {
    
    func didTapButton(in cell: ToDoTableViewCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            presenter?.togleTask(indexOfCell: indexPath.row,
                                 indexOfSection: filterSegmentedContoll.selectedSegmentIndex)
        }
    }
}
