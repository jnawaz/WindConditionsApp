//
//  AbstractCity+CoreDataProperties.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 08/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//
//

import Foundation
import CoreData


extension AbstractCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AbstractCity> {
        return NSFetchRequest<AbstractCity>(entityName: "AbstractCity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?
    @NSManaged public var coordinates: Coordinates?

}
