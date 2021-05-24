//
//  PersistenceController.swift
//  Qode
//
//  Created by Jakub "GPH4PPY" Dąbrowski on 20/05/2021.
//

import UIKit
import CoreData

class PersistenceController {
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "QodeData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    /// This method saves the context.
    static func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
