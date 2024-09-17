//
//  TaskInteractor.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import Foundation

class MainInteractor: MainInteractorInputProtocol {

    
    
    var presenter: MainInteractorOutputProtocol?
    var coreDaraManager: (any CoreDataInputProtocol)?
    var networkManager: NetworkManagerInputProtocol?
    
    var todos: [TaskEntityDTO] = [] {
        didSet {
            presenter?.retrieveComplitionMark()
        }
    }
    
    func getTodosFromIneractor() -> [TaskEntityDTO] {
        return todos
    }

    func getTodosFromDB()  {
            self.coreDaraManager?.getDataFromStorage()
    }
    
    func toogleCompletedInteractor(task: TaskEntityDTO) {
        coreDaraManager?.toogleCompleted(id: task.id)
    }
    
    func saveTodo(_ todo: TaskEntity) {
        //
    }
    
    func deleteTodo(_ todo: TaskEntityDTO) {
        coreDaraManager?.delete(id: todo.id)
    }
    
    func addToDoFromNetwork() {
        
        networkManager?.fetchDataComplition(complition: { result in
            switch result {
            case .success(let taskData):
                print(taskData)
                UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
                for i in 0..<taskData.todos.count {
                    self.coreDaraManager?.addNewTask(taskName: taskData.todos[i].todo,
                                                                              dueOn: Date.now)
                }
                self.getTodosFromDB()
                
            case .failure(let failure):
                print(failure)
            }
        }
        )}
    }

extension MainInteractor: CoreDataOtputProtocol {
    
    func retrieveData(_ todo: [TaskEntityDTO]) {
        self.todos = todo
    }
}
