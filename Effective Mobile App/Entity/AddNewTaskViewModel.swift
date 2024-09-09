//
//  AddNewTaskViewModel.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 04.09.2024.
//

import Foundation

class AddNewTaskViewModel {
    func addTask(taskName: String, dueOn: Date) {
        CoreDataManager.shared.addNewTask(taskName: taskName, dueOn: dueOn)
    }
}
