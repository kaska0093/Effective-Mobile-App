//
//  Router.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import UIKit


class MainRouter: TodoListRouterProtocol {
    
    static func createTodoListModule() -> UIViewController {
        
        let mainViewController = ViewController()
        //let navViewController = UINavigationController(rootViewController: mainViewController)
        
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let router = MainRouter()
        let coreDaraManager = CoreDataManager()
        let networkManager = NetworkManager()
        
        mainViewController.presenter = presenter
        
        presenter.view = mainViewController
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.coreDaraManager = coreDaraManager
        interactor.networkManager = networkManager
        
        coreDaraManager.interactor = interactor
        
        return mainViewController
    }
    
    func presentToDoDetailScreen(from view: MainViewInput, for todo: TaskEntityDTO?) {

        let addVC = AddRouter.createTodoDetailRouterModule(with: todo)
        
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        //viewVC.navigationController?.pushViewController(addVC, animated: true)
        addVC.modalPresentationStyle = .fullScreen
        viewVC.present(addVC, animated: true)
    }
}
