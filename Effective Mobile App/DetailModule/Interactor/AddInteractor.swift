//
//  AddNewTaskViewModel.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 04.09.2024.
//

import Foundation

class AddInteractor: AddInteractorInputProtocol {
    
    var presenter: (any AddInteractorOutputProtocol)?
    var coreDaraManager: (any AddCoreDataInputProtocol)?

    
    func saveTodo(_ todo: TaskEntity) {
        //
    }
    
    
    var selectedTask: TaskEntityDTO? {
        didSet {
            print(selectedTask ?? "pusto")
        }
    }
    
    func addTask(taskName: String, dueOn: Date) {
       // CoreDataManager.shared.addNewTask(taskName: taskName, dueOn: dueOn)
    }
}
