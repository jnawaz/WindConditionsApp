//
//  FavouriteCities+CoreDataClass.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 08/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FavouriteCities)
public class FavouriteCities: AbstractCity {

    class func hasStoredFavourites(with context: NSManagedObjectContext) -> Bool {
        var favouriteCities = -1
        var favouriteCitiesRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteCities")
        do {
            favouriteCities = try context.fetch(favouriteCitiesRequest).count
        } catch {
            fatalError("Fundamental error fetching favourite cities")
        }
        return favouriteCities > 0
    }
}
