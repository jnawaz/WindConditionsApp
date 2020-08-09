//
//  FavouriteCities+CoreDataProperties.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 08/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//
//

import Foundation
import CoreData


extension FavouriteCities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteCities> {
        return NSFetchRequest<FavouriteCities>(entityName: "FavouriteCities")
    }

    @NSManaged public var isFavourite: Bool

}
