//
//  Protocols.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 17.09.2024.
//

import UIKit


protocol AddViewInput: AnyObject {
    // PRESENTER -> VIEW
    var presenter: AddViewOutput? { get set }
    
    func updateUI(task:String, dueOn: Date)
}


protocol AddViewOutput: AnyObject {
    // VIEW -> PRESENTER
    var view: AddViewInput? { get set }
    var interactor: AddInteractorInputProtocol? { get set }
    var router: AddRouterProtocol? { get set }


    func userPressedAddButton(taskName: String, dueOn: Date) 
    func userPressedUpdateButton(taskName: String, dueOn: Date)
}

protocol AddInteractorInputProtocol: AnyObject {
    
    var presenter: AddInteractorOutputProtocol? { get set }
    var coreDaraManager:AddCoreDataInputProtocol? { get set }
    
    var selectedTask: TaskEntityDTO? { get set }
    
    // PRESENTER -> INTERACTOR

    func updateTask(taskName: String, dueOn: Date)
    func addTask(taskName: String, dueOn: Date)
}

protocol AddInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func retrieveComplitionMark()
    func setupUIForEdditing(task:String, dueOn: Date) 
}

protocol AddRouterProtocol: AnyObject {
    
    static func createTodoDetailRouterModule(with todo: TaskEntityDTO?) -> UIViewController

    // PRESENTER -> ROUTER
    func navigateBackToListViewController(from view: AddViewInput)
}

protocol AddCoreDataInputProtocol: AnyObject {
   // INTERACTOR -> CORE_DATA_MANAGER
 //   var interactor: CoreDataOtputProtocol? { get set }
    
    // вставить функцию с замыкание
    func addNewTaskWithComplition(taskName: String,
                                  dueOn: Date,
                                  complition: @escaping (Result<Bool,Error>) -> Void)
    
    func updateTaskWithComplition(id: UUID,
                                  taskName: String,
                                  dueOn: Date,
                                  complition: @escaping (Result<Bool,Error>) -> Void)
    

}


