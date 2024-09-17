//
//  TaskPresenter.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import UIKit



final class MainPresenter: MainViewOutput {

    
    var router: TodoListRouterProtocol?
    var interactor: MainInteractorInputProtocol?
    weak var view: MainViewInput?
    
    func viewWillAppear() {
        interactor?.getTodosFromDB()
    }
    
    func togleTask(indexOfCell: Int, indexOfSection: Int) {
        
        if let task = getTaskAt(indexOfCell: indexOfCell, indexOfSection: indexOfSection) {
            interactor?.toogleCompletedInteractor(task: task)
        }
        interactor?.getTodosFromDB()
    }
    
    
    func showTodoDetail(indexOfCell: Int, indexOfSection: Int) {
        if let task = getTaskAt(indexOfCell: indexOfCell, indexOfSection: indexOfSection) {
            guard let view = view else { return }
            router?.presentToDoDetailScreen(from: view, for: task)
        }
    }
    
    func addTodo() {
        guard let view = view else { return }
        router?.presentToDoDetailScreen(from: view, for: nil)
    }
    
    func presenterAddToDoFromNetwork() {
        
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            self.interactor?.addToDoFromNetwork()
        }
    }
    
    func removeTodo(indexOfCell: Int, indexOfSection: Int) {
        
        if let task = getTaskAt(indexOfCell: indexOfCell, indexOfSection: indexOfSection) {
            interactor?.deleteTodo(task)
        }
        interactor?.getTodosFromDB()
    }
    
    func getNumberOfTasks(indexOfSection: Int) -> Int {
        
        if indexOfSection == 0 {
            return interactor?.getTodosFromIneractor().count ?? 0
        } else if indexOfSection == 1 {
            return interactor?.getTodosFromIneractor().filter { $0.copmleted }.count ?? 0
        } else {
            return interactor?.getTodosFromIneractor().filter { !$0.copmleted }.count ?? 0
        }
    }

    func getTaskAt(indexOfCell: Int, indexOfSection: Int) -> TaskEntityDTO? {
        
        guard let tasks = interactor?.getTodosFromIneractor() else {
            return nil
        }
        if indexOfSection == 0 {
            return tasks[indexOfCell]
        } else if indexOfSection == 1 {
            return tasks.filter { $0.copmleted }[indexOfCell]
        } else {
            return tasks.filter { !$0.copmleted }[indexOfCell]
        }
    }
    
    func getTasksCountByType() -> (complete: Int, incomplete: Int, common: Int) {
        
        let completedCount = interactor?.getTodosFromIneractor() .lazy.filter { $0.copmleted}.count
        let inCompletedCount = interactor?.getTodosFromIneractor() .lazy.filter { !$0.copmleted}.count
        let commonCount = interactor?.getTodosFromIneractor().count
        
        guard let value1 = completedCount, let value2 = inCompletedCount, let value3 = commonCount else  {
            return (0, 0, 0)
        }
        return(value1, value2, value3)
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    
    func didAddTodo(_ todo: TaskEntity) {
        //
    }
    
    func didRemoveTodo(_ todo: TaskEntity) {
        //
    }
    
    func retrieveComplitionMark() {
        DispatchQueue.main.async {
            self.view?.updateUI()
        }
    }
    
    func onError(message: String) {
        //
    }
    
    
}
