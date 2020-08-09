//
// Created by Jamil Nawaz on 08/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation
import CoreData
import XCTest

class CoreDataTestStack {
    let persistentContainer: NSPersistentContainer

    var mainContext: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    init() {
        persistentContainer = NSPersistentContainer(name: "WindConditionsApp")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType

        persistentContainer.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
    }

    func clearCoreDataStore() {

        for entity in persistentContainer.managedObjectModel.entities {

            guard let entityName = entity.name else {
                continue
            }

            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
            fetchRequest.includesPropertyValues = false

            do {

                let objects = try mainContext.fetch(fetchRequest)
                objects.forEach(mainContext.delete)

            } catch {
                fatalError("Unable to perform batch delete for entity: \(entityName), error: \(error)")
            }

        }

        do {
            try mainContext.save()
        } catch {
            fatalError("Failed to clear entities")
        }

    }
}