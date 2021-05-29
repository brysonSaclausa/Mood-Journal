//
//  CoreDataStack.swift
//  iosJournalProject
//
//  Created by BrysonSaclausa on 8/5/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Journal")
        container.loadPersistentStores { (_, error) in
        if let error = error {
            fatalError("\(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    
    }()//
    
    func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
        var error: Error?
        context.performAndWait {
            do {
                try context.save()
            } catch let saveError {
                error = saveError
            }
        }
        if let error = error { throw error }
    }//
    
    var mainContext: NSManagedObjectContext {
    return container.viewContext
    
   }
}
