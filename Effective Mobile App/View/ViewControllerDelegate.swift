//
//  ViewControllerDelegate.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 04.09.2024.
//

import UIKit

extension ViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate


//       func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//           return 50 // Высота нижнего колонтитула для создания разделения
//       }
//       
//       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//           return 0 // Ноль высоты для заголовка
//       }

    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       // let countCompletedTasks = viewModel.tasks.filter { $0.copmleted }.count
        var completeAction = UIContextualAction()
        
        let task = viewModel.currentTask(by: indexPath.row)
        completeAction = UIContextualAction(style: .normal, title: task.copmleted ? "Not completed" : "Complete") { [weak self] (action, view, complitionHandler) in
            self?.completetask(at: indexPath.row) //+ countCompletedTasks)
            complitionHandler(true)
        }
        completeAction.backgroundColor = task.copmleted ? .red : .green
        
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        configuration.performsFirstActionWithFullSwipe = true
        // более 50: проведенного свайка считается что кнока нажата
        return configuration
    }
    
    
    func completetask(at indexPathRow: Int) {
        let task = viewModel.currentTask(by: indexPathRow)
        viewModel.toogleCompleted(task: task)
        
        if task.copmleted {
//            celebrateAnimationView.isHidden = false
 //           celebrateAnimationView.play { finished in
 //               self.celebrateAnimationView.isHidden = finished
   //         }
        }
        tableView.reloadData()
//        tableView.reloadRows(at: [indexPath], with: .automatic)
//        tableView.reloadRows(at: [IndexPath.SubSequence(row: 0, section: 0)], with: .automatic)
    }
    




}

extension ViewController: CustomCellDelegate {
    func didTapButton(in cell: ToDoTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            print("Нажата кнопка в ячейке с индексом: \(indexPath.row)")
            
             let task = viewModel.currentTask(by: indexPath.row)
          //   completeAction = UIContextualAction(style: .normal, title: task.copmleted ? "Not completed" : "Complete") { [weak self] (action, view, complitionHandler) in
            self.completetask(at: indexPath.row) //+ countCompletedTasks)
           //      complitionHandler(true)
       //      }
      //       completeAction.backgroundColor = task.copmleted ? .red : .green
      
  //           let configuration = UISwipeActionsConfiguration(actions: [completeAction])
 //            configuration.performsFirstActionWithFullSwipe = true
             // более 50: проведенного свайка считается что кнока нажата
            
            
        }
    }
}
