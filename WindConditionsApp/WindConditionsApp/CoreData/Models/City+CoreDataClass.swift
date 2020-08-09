//
//  City+CoreDataClass.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 08/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//
//

import Foundation
import CoreData

@objc(City)
public class City: AbstractCity {

    class func hasStoredCities(with context: NSManagedObjectContext) -> Bool {
        var cities = -1
        let citiesRequest = NSFetchRequest<NSManagedObject>(entityName: "City")
        do {
            cities = try context.fetch(citiesRequest).count
        } catch {
            fatalError("Fundamental error fetching cities")
        }
        return cities > 0
    }

    class func populateAndInsertCity(_ city: CityStruct, with context: NSManagedObjectContext) {
        let cityManagedObject = NSEntityDescription.insertNewObject(forEntityName: "City", into: context) as! City
        if let cityName = city.name {
            cityManagedObject.name = cityName
        }
        if let cityState = city.state {
            cityManagedObject.state = cityState
        }
        if let cityCountry = city.country {
            cityManagedObject.country = cityCountry
        }
        if let cityLongLat = city.coord {
            let longLatManagedObject = NSEntityDescription.insertNewObject(forEntityName: "Coordinates", into: context) as! Coordinates
            longLatManagedObject.longitude = cityLongLat.lon
            longLatManagedObject.latitude = cityLongLat.lat
        }
    }

    class func searchFor(_ city: String, with context: NSManagedObjectContext) -> [City]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "City")
        fetchRequest.predicate = NSPredicate(format: "name == %@", city)
        var citiesFound = [NSManagedObject]()
        do {
            if let cities: [NSManagedObject] = try context.fetch(fetchRequest) {
                citiesFound = cities
            }

        } catch {
            return nil
        }
        return citiesFound as? [City]
    }
}
