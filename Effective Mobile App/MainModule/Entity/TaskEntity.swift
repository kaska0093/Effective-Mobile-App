//
//  TaskEntity.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import Foundation

struct TaskEntity {
    
    private var task: TaskModelFromDB
    
    init(task: TaskModelFromDB) {
        self.task = task
    }
    
    var copmleted: Bool {
        task.completed
    }
    var id: UUID {
        task.id ?? UUID()
    }
    var name: String {
        task.todo ?? ""
    }
    var dueOn: Date {
        task.dueOn ?? Date()
    }
    var copmletedOn: Date {
        task.completedOn ?? Date()
    }
}


struct TaskEntityDTO {

    var copmleted: Bool
    var id: UUID
    var name: String
    var dueOn: Date
    var copmletedOn: Date
}

struct TaskResultsFromNetwork: Codable {
    
    let todos: [Todo]
    let total, skip, limit: Int
    
    // MARK: - Todo
    struct Todo: Codable {
        let id: Int
        let todo: String
        let completed: Bool
        let userID: Int

        enum CodingKeys: String, CodingKey {
            case id, todo, completed
            case userID = "userId"
        }
    }
}
