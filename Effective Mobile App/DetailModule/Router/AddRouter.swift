//
//  ToDoAddadnDetail.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 17.09.2024.
//

import UIKit

class AddRouter: AddRouterProtocol {

    static func createTodoDetailRouterModule(with todo: TaskEntityDTO) -> UIViewController {
        
        let addViewController = AddViewController()
        
        let presenter = AddPresenter()
        let interactor = AddInteractor()
        let router = AddRouter()
        let coreDadaManager = CoreDataManager()
        
        addViewController.presenter = presenter
        
        presenter.view = addViewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.coreDaraManager = coreDadaManager
        interactor.selectedTask = todo
        
        
        return addViewController
    }
}
