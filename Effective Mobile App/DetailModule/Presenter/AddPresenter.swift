//
//  AddPresenter.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 17.09.2024.
//

import Foundation

class AddPresenter: AddViewOutput {
    
    var view: (any AddViewInput)?
    
    var interactor: (any AddInteractorInputProtocol)?

    var router: (any AddRouterProtocol)?
    
    func viewWillAppear() {
        //
    }
    
    
}

extension AddPresenter: AddInteractorOutputProtocol {
    
    func retrieveComplitionMark() {
        //
    }
}
