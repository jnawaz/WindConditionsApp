//
//  FavouriteLocationViewDelegate.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

protocol FavouriteLocationViewDelegate: class {
    func showEmptyFavouritesView()
    func hideEmptyFavouritesView()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showFavouritesView(favCities: [FavouriteCities])
    func showAddCityInstructionView()
    func showFavouritesView()
    func showSearchResultsTable()
}
