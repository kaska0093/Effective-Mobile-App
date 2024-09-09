//
//  TaskViewModel.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 04.09.2024.
//

import Foundation

struct TaskViewModel {
    
    private var task: TaskModel
    
    init(task: TaskModel) {
        self.task = task
    }
    
    var copmleted: Bool {
        task.completed
    }
    
    var id: UUID {
        task.id ?? UUID()
    }
    
    var name: String {
        task.todo ?? ""
    }
    
    var dueOn: Date {
        task.dueOn ?? Date()
    }
    
    var copmletedOn: Date {
        task.completedOn ?? Date()
    }
}
