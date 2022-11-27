//
//  CoreDataManager.swift
//  AlexCoto
//
//  Created by Alexander Coto on 26/11/22.
//

import Foundation
import CoreData

class CoreDataManager {

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AlexCoto")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    func saveContext() {
        guard managedContext.hasChanges else { return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PostMO")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try storeContainer.viewContext.execute(deleteRequest)
        } catch _ as NSError {
            // TODO: handle the error
        }
    }
}
