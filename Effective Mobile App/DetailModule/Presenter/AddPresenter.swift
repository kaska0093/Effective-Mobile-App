//
//  AddPresenter.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 17.09.2024.
//

import Foundation

class AddPresenter: AddViewOutput {
    
    var view: AddViewInput?
    var interactor:  AddInteractorInputProtocol?
    var router: AddRouterProtocol?
    
    func userPressedAddButton(taskName: String, dueOn: Date) {
        interactor?.addTask(taskName: taskName,
                            dueOn: dueOn)
    }
    
    func userPressedUpdateButton(taskName: String, dueOn: Date) {
        interactor?.updateTask(taskName: taskName,
                               dueOn: dueOn)
    }
    
    func userPressedExit() {
        if let view = view {
            router?.navigateBackToListViewController(from: view)
        }    }
    
    
}

extension AddPresenter: AddInteractorOutputProtocol {
    
    func retrieveComplitionMark() {
        if let view = view {
            router?.navigateBackToListViewController(from: view)
        }
    }
    
    func setupUIForEdditing(task:String, dueOn: Date) {
        view?.updateUI(task: task,
                       dueOn: dueOn)
    }
}
