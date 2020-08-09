//
//  CoreDataStack.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

    static let shared = CoreDataStack()

    lazy var mainContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WindConditionsApp")
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("")
            }
        }
        return container
    }()
}
