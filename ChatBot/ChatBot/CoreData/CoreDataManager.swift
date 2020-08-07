//
//  CoreDataManager.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    let dataModelName = Constants.coreDataModelName
    static let shared = CoreDataManager()
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dataModelName)
        let description = NSPersistentStoreDescription()
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        description.url = NSPersistentContainer.defaultDirectoryURL().appendingPathComponent(dataModelName + ".sqlite")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: {
            _, error in
            if let error = error as NSError? {
                assertionFailure("\(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func fetchObjects<T>(fetchRequest: NSFetchRequest<T>, context: NSManagedObjectContext) -> [T] {
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching objects with : \(error)")
        }
        return []
    }
    
    func saveContext(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Could not save context\(error)")
        }
    }
    
    func batchDelete(objects: [NSManagedObject], context: NSManagedObjectContext) {
        let objectIds: [NSManagedObjectID] = objects.map {$0.objectID}
        let batchDeleteRequest = NSBatchDeleteRequest(objectIDs: objectIds)
        
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            assertionFailure("Could not delete with error \(error)")
        }
    }
}
