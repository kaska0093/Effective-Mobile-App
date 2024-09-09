//
//  CoreDataManager.swift
//  Effective Mobile App
//
//  Created by Nikita Shestakov on 03.09.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
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
    
    func getAll() -> [TaskModel] {
        var tasks = [TaskModel]()
        let fetchRequest: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "dueOn", ascending: true)
        fetchRequest.sortDescriptors = [sortByDueDate]
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return tasks
    }
    
    func addNewTask(taskName: String, dueOn: Date) {
        let task = TaskModel(context: context)
        task.todo = taskName
        task.dueOn = dueOn
        task.id = UUID()
        task.completed = false
        saveContext()
    }
    
    func toogleCompleted(id: UUID) {
        let fetchRequest: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()
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
        let fetchRequest: NSFetchRequest<TaskModel> = TaskModel.fetchRequest()
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
