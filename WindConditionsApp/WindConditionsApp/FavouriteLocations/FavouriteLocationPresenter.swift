//
//  FavouriteLocationPresenter.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit
import CoreData

class FavouriteLocationPresenter: NSObject {
    weak var viewDelegate: FavouriteLocationViewDelegate?
    var managedObjectContext: NSManagedObjectContext?
    let filename = "citylist"
    let filetype = "json"

    init(viewDelegate: FavouriteLocationViewDelegate,
         managedObjectContext: NSManagedObjectContext) {
        super.init()
        self.viewDelegate = viewDelegate
        self.managedObjectContext = managedObjectContext
    }

    func viewDidLoad() {
        if let coreDataContext = managedObjectContext {
            if City.hasStoredCities(with: coreDataContext) {
                if FavouriteCities.hasStoredFavourites(with: coreDataContext) {
                    self.viewDelegate?.showFavouritesView()
                } else {
                    self.viewDelegate?.hideEmptyFavouritesView()
                }
            } else {
                self.viewDelegate?.showEmptyFavouritesView()
                self.viewDelegate?.showLoadingIndicator()
                self.populateCityData()
                self.viewDelegate?.hideLoadingIndicator()
            }
        }
    }

    private func populateCityData() {
        guard let cities = CityListDecoder().getCityData() else {
            return
        }

        if let coreDataContext = managedObjectContext {
            for city in cities {
                City.populateAndInsertCity(city, with: coreDataContext)
            }
            do {
                try coreDataContext.save()
            } catch {
                fatalError("Failed to save cities")
            }
        }
    }

    func searchFor(city: String, completionHandler: @escaping ([City]?) -> Void) {
        if let coreDataContext = managedObjectContext {
            let searchedCities = City.searchFor(city, with: coreDataContext)
            if let searchCityResult = searchedCities {
                if !searchCityResult.isEmpty {
                    completionHandler(searchCityResult)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
}
