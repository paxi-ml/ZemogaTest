//
//  CoreDataManager.swift
//  AlexCoto
//
//  Created by Alexander Coto on 26/11/22.
//

import Foundation
import CoreData
import UIKit

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
    
    func fetchPosts() -> [Post] {
        var posts:[Post] = []
        let postFetch: NSFetchRequest<PostMO> = PostMO.fetchRequest()
        do {
            if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.coreDataManager.managedContext {
                
                let results = try managedContext.fetch(postFetch)
                for result in results {
                    let post = Post()
                    post.title = result.title ?? ""
                    //In here we parse all the rest of the attributes
                    posts.append(post)
                }
            }
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
        }
        return posts
    }
    
    func savePost(_ post:Post) {
        if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.coreDataManager.managedContext {
            let postMO = PostMO(context: managedContext)
            postMO.setValue(post.title, forKey: #keyPath(PostMO.title))
            //In here we can save all other values
            (UIApplication.shared.delegate as? AppDelegate)?.coreDataManager.saveContext()
        }
    }
}
