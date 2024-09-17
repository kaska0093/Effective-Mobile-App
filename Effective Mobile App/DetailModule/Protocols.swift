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

    func updateUI()
}


protocol AddViewOutput: AnyObject {
    // VIEW -> PRESENTER
    var view: AddViewInput? { get set }
    var interactor: AddInteractorInputProtocol? { get set }
    var router: AddRouterProtocol? { get set }


    func viewWillAppear()
}

protocol AddInteractorInputProtocol: AnyObject {
    
    var presenter: AddInteractorOutputProtocol? { get set }
    var coreDaraManager:AddCoreDataInputProtocol? { get set }
    
    var selectedTask: TaskEntityDTO? { get set }
    
    // PRESENTER -> INTERACTOR

    func saveTodo(_ todo: TaskEntity)
}

protocol AddInteractorOutputProtocol: AnyObject {
    
    // INTERACTOR -> PRESENTER
    func retrieveComplitionMark()
}

protocol AddRouterProtocol: AnyObject {
    
    static func createTodoDetailRouterModule(with todo: TaskEntityDTO) -> UIViewController

    // PRESENTER -> ROUTER
}

protocol AddCoreDataInputProtocol: AnyObject {
   // INTERACTOR -> CORE_DATA_MANAGER
    var interactor: CoreDataOtputProtocol? { get set }
    
    // вставить функцию с замыкание
    

}


