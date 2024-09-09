//
//  Task.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import Foundation

 
    struct TaskResults: Codable {
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
