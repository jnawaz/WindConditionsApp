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
    var isSearching = false

    init(viewDelegate: FavouriteLocationViewDelegate,
         managedObjectContext: NSManagedObjectContext) {
        super.init()
        self.viewDelegate = viewDelegate
        self.managedObjectContext = managedObjectContext
    }

    func viewWillAppear() {
        if let coreDataContext = managedObjectContext {
            if City.hasStoredCities(with: coreDataContext) {
                if FavouriteCities.hasStoredFavourites(with: coreDataContext) {
                    let favourites = FavouriteCities.all(with: coreDataContext)
                    if let favouriteCities = favourites {
                        self.viewDelegate?.showFavouritesView(favCities: favouriteCities)
                    }
                } else {
                    self.viewDelegate?.hideEmptyFavouritesView()
                    self.viewDelegate?.showAddCityInstructionView()
                }
            } else {
                self.viewDelegate?.showEmptyFavouritesView()
                self.viewDelegate?.showLoadingIndicator()
                self.populateCityData()
                self.viewDelegate?.hideLoadingIndicator()
                self.viewDelegate?.showAddCityInstructionView()
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

    func configureViews() {
        if let coreDataContext = self.managedObjectContext {
            if let favourties = FavouriteCities.all(with: coreDataContext) {
                if favourties.isEmpty {
                    viewDelegate?.showAddCityInstructionView()
                } else {
                    if isSearching {
                        viewDelegate?.showSearchResultsTable()
                    } else {
                        viewDelegate?.showFavouritesView()
                    }
                }
            }
        }
    }
}
