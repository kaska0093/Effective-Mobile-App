//
//  Protocols.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 12.09.2024.
//

import UIKit


protocol MainViewOutput: AnyObject {
    // VIEW -> PRESENTER
    var view: MainViewInput? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }


    func viewWillAppear()
    func togleTask(indexOfCell: Int, indexOfSection: Int)
    func showTodoDetail(indexOfCell: Int, indexOfSection: Int)
    func addTodo()
    func removeTodo(indexOfCell: Int, indexOfSection: Int)
    func presenterAddToDoFromNetwork()
    
    func getNumberOfTasks(indexOfSection: Int) -> Int 
    func getTaskAt(indexOfCell: Int, indexOfSection: Int) -> TaskEntityDTO?
    func getTasksCountByType() -> (complete: Int, incomplete: Int, common: Int)
}

protocol MainViewInput: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MainViewOutput? { get set }

    func updateUI()
    func showErrorMessage(_ message: String)
}


protocol MainInteractorInputProtocol: AnyObject {
    
    var presenter: MainInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func getTodosFromIneractor() -> [TaskEntityDTO] 
    func getTodosFromDB()
    func saveTodo(_ todo: TaskEntity)
    func deleteTodo(_ todo: TaskEntityDTO)
    func toogleCompletedInteractor(task: TaskEntityDTO)
    func addToDoFromNetwork()
}

protocol MainInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func didAddTodo(_ todo: TaskEntity)
    func didRemoveTodo(_ todo: TaskEntity)
    func retrieveComplitionMark()
    func onError(message: String)
}


protocol TodoListRouterProtocol: AnyObject {
    
    static func createTodoListModule() -> UIViewController
    
    // PRESENTER -> ROUTER
    func presentToDoDetailScreen(from view: MainViewInput, for todo: TaskEntityDTO?)
}

protocol CoreDataInputProtocol: AnyObject {
   // INTERACTOR -> CORE_DATA_MANAGER
    var interactor: CoreDataOtputProtocol? { get set }
    
    func getDataFromStorage()
    func toogleCompleted(id: UUID) 
    func delete(id: UUID)
    func addNewTask(taskName: String, dueOn: Date)
}

protocol CoreDataOtputProtocol: AnyObject {
    //  CORE_DATA_MANAGER -> INTERACTOR
    
    var coreDaraManager: CoreDataInputProtocol? { get set }
    
    func retrieveData(_ todo: [TaskEntityDTO])

}

protocol NetworkManagerInputProtocol: AnyObject {
    func fetchDataComplition(complition: @escaping (Result<TaskResultsFromNetwork, Error>) -> Void)
}
