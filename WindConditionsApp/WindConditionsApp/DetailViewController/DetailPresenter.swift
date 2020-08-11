//
// Created by Jamil Nawaz on 09/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation
import CoreData

class DetailPresenter: NSObject {
    weak var viewDelegate: DetailViewDelegate?
    var managedObjectContext: NSManagedObjectContext?

    init(viewDelegate: DetailViewDelegate,
         managedObjectContext: NSManagedObjectContext) {
        super.init()
        self.viewDelegate = viewDelegate
        self.managedObjectContext = managedObjectContext
    }

    func addToFavourites(_ city: City!) {
        if let coreDataContext = managedObjectContext {
            let favourite = NSEntityDescription.insertNewObject(forEntityName: "FavouriteCities", into: coreDataContext) as! FavouriteCities

            favourite.isFavourite = true
            let coordinates = NSEntityDescription.insertNewObject(forEntityName: "Coordinates", into: coreDataContext) as! Coordinates
            coordinates.latitude = city.coordinates?.latitude as! Float
            coordinates.longitude = city.coordinates?.longitude as! Float
            favourite.coordinates = coordinates
            favourite.name = city.name
            favourite.id = city.id
            favourite.country = city.country
            favourite.state = city.state

            do {
                try coreDataContext.save()
                viewDelegate?.successfullySaved()
            } catch {
                viewDelegate?.failedToSave()
            }
        }
    }
}