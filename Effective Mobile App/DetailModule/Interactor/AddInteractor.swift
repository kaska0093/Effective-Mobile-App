//
//  AddNewTaskViewModel.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 04.09.2024.
//

import Foundation

class AddInteractor: AddInteractorInputProtocol {
    
    var presenter: AddInteractorOutputProtocol?
    var coreDaraManager: AddCoreDataInputProtocol?

    
    var selectedTask: TaskEntityDTO? {
        didSet {
            presenter?.setupUIForEdditing(task: selectedTask!.name,
                                          dueOn: selectedTask!.dueOn)
        }
    }
    
    func addTask(taskName: String, dueOn: Date) {
        
        coreDaraManager?.addNewTaskWithComplition(taskName: taskName,
                                    dueOn: dueOn, complition: { result in
            switch result {
            case .success(_):
                self.presenter?.retrieveComplitionMark()
            case .failure(_):
                print("ne ok")
            }
        })
    }
    
    func updateTask(taskName: String, dueOn: Date) {
        
        if let task = selectedTask {
            coreDaraManager?.updateTaskWithComplition(id: task.id,
                                                      taskName: taskName,
                                                      dueOn: dueOn,
                                                      complition: { result in
                switch result {
                case .success(_):
                    self.presenter?.retrieveComplitionMark()
                case .failure(_):
                    print("ne ok")
                }
            })
        }
    }
}
