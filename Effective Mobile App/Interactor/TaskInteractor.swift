//
//  TaskInteractor.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import Foundation

class TaskListViewModel {
    
    var tasks = [TaskViewModel]()
    
    init() {
        getAll()
    }
    
    func getAll() {
        tasks = CoreDataManager.shared.getAll().map(TaskViewModel.init)
    }
    
    func currentTask(by index: Int) -> TaskViewModel {
        print(index)
        print(tasks)
        return tasks[index]
    }
    
    func toogleCompleted(task: TaskViewModel) {
        // call core data to toggle completes state
        print("togle \(task.name)")
        CoreDataManager.shared.toogleCompleted(id: task.id)
        getAll()
    }
    
    func getTasksByType() -> (complete: Int, incomplete: Int) {
        let completedCount = tasks.lazy.filter( { (task: TaskViewModel) -> Bool in
            return task.copmleted
        }).count
        let inCompletedCount = tasks.lazy.filter({task in
            !task.copmleted}).count
        //let inCompletedCount = tasks.lazy.filter({$0.copmleted})
        return (completedCount, inCompletedCount)
    }
    
    func deleteItem(task: TaskViewModel) {
        // call core data to deleta the task
        CoreDataManager.shared.delete(id: task.id)
        getAll()
    }
}
