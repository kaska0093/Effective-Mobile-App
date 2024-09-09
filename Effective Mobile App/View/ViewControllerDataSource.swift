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
            let task = viewModel.tasks
            return task.count
        } else if filterSegmentedContoll.selectedSegmentIndex == 1 {
            let task = viewModel.tasks.filter { $0.copmleted }
            return task.count
        } else {
            let task = viewModel.tasks.filter { !$0.copmleted }
            return task.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
        
        if filterSegmentedContoll.selectedSegmentIndex == 0 {
            let task = viewModel.tasks
            cell.configure(with: task[indexPath.row])
        } else if filterSegmentedContoll.selectedSegmentIndex == 1 {
            let task = viewModel.tasks.filter { $0.copmleted }[indexPath.row]
            cell.configure(with: task)
        } else {
            let task = viewModel.tasks.filter { !$0.copmleted }[indexPath.row]
            cell.configure(with: task)

        }
        cell.delegate = self
        return cell
    }
    
//    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return section == 0 ? 0 : 40 // устанавливает высоту заголовка
//    }
//
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "Конец секции \(section)" // возвращает текст для подвала каждой секции
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return section == 0 ? 0 : 20 // устанавливает высоту подвала
//    }
    
    
}
