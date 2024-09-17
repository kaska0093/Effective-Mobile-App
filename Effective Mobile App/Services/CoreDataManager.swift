//
//  CoreDataManager.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    
    var interactor: CoreDataOtputProtocol?
    
    func saveContext() {
        let context = persistantContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    lazy var persistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistantContainer.viewContext
    }
}

extension CoreDataManager: AddCoreDataInputProtocol {
    
    func updateTaskWithComplition(id: UUID, taskName: String, dueOn: Date, complition: @escaping (Result<Bool, any Error>) -> Void) {
        
        let fetchRequest: NSFetchRequest<TaskModelFromDB> = TaskModelFromDB.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            let fetchTasks = try context.fetch(fetchRequest)
            for task in fetchTasks {
                task.dueOn = dueOn
                task.todo = taskName
            }
            saveContext()
            complition(.success(true))
        } catch let error as NSError {
            complition(.failure(error))
        }
    }
    
    
    func addNewTaskWithComplition(taskName: String, dueOn: Date, complition: @escaping (Result<Bool, any Error>) -> Void) {
        
        let task = TaskModelFromDB(context: context)
        task.todo = taskName
        task.dueOn = dueOn
        task.id = UUID()
        task.completed = false
        saveContext()
        complition(.success(true))
    }
}

extension CoreDataManager: CoreDataInputProtocol {
    
    func addNewTask(taskName: String, dueOn: Date) {
        let task = TaskModelFromDB(context: context)
        task.todo = taskName
        task.dueOn = dueOn
        task.id = UUID()
        task.completed = false
        saveContext()
    }
    
    func getDataFromStorage() {
        
        var tasks = [TaskModelFromDB]()
        let fetchRequest: NSFetchRequest<TaskModelFromDB> = TaskModelFromDB.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "dueOn", ascending: true)
        fetchRequest.sortDescriptors = [sortByDueDate]
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    
        let mapper = Mapper()
  
        let result = tasks.map(TaskEntity.init)
    
        let bif = result.map { task in
            return mapper.mapToDTO(from: task)
        }

        interactor?.retrieveData(bif)
    }

        
          
    func toogleCompleted(id: UUID) {
        
        let fetchRequest: NSFetchRequest<TaskModelFromDB> = TaskModelFromDB.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
            let fetchTasks = try context.fetch(fetchRequest)
            for task in fetchTasks {
                task.completed = !task.completed
                if task.completed {
                    task.completedOn = Date()
                }
            }
            saveContext()
        } catch let error as NSError {
            print(error.userInfo)
        }
    }
    
    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<TaskModelFromDB> = TaskModelFromDB.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
        do {
            let fetchTasks = try context.fetch(fetchRequest)
            for task in fetchTasks {
                context.delete(task)
            }
            saveContext()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
