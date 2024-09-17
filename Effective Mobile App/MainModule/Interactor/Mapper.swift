//
//  Mapper.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 13.09.2024.
//

import Foundation


class Mapper {
    
    func mapToEntity(from dto: TaskEntityDTO) -> TaskEntity {
        
        let task = TaskModelFromDB()
        task.completed = dto.copmleted
        task.id = dto.id
        task.todo = dto.name
        task.dueOn = dto.dueOn
        task.completedOn = dto.copmletedOn

        return TaskEntity(task: task)
    }
    
    func mapToDTO(from entity: TaskEntity) -> TaskEntityDTO {

        return TaskEntityDTO(copmleted: entity.copmleted,
                             id: entity.id,
                             name: entity.name,
                             dueOn: entity.dueOn,
                             copmletedOn: entity.copmletedOn)
    }
}
