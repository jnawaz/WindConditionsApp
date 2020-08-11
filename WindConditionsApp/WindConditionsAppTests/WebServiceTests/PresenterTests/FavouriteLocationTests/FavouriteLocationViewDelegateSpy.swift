//
//  FavouriteLocationViewDelegateSpy.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class FavouriteLocationViewDelegateSpy: FavouriteLocationViewDelegate {
    func showSearchResultsTable() {

    }

    var shouldShowEmptyFavouritesView = false
    var shouldHideEmptyFavouritesView = false
    var shouldShowLoadingIndicator = false
    var shouldHideLoadingIndicator = false
    var shouldShowFavouritesView = false
    var shouldShowAddCityInstructionView = false
    var showsFavouriteCities = false
    var shouldShowFavouritesViewWithCities = false

    func showEmptyFavouritesView() {
        shouldShowEmptyFavouritesView = true
    }

    func hideEmptyFavouritesView() {
        shouldHideEmptyFavouritesView = true
    }

    func showLoadingIndicator() {
        shouldShowLoadingIndicator = true
    }

    func hideLoadingIndicator() {
        shouldHideLoadingIndicator = true
    }

    func showFavouritesView() {
        shouldShowFavouritesView = true
    }

    func showAddCityInstructionView() {
        shouldShowAddCityInstructionView = true
    }

    func showFavouritesView(favCities: [FavouriteCities]) {
        shouldShowFavouritesViewWithCities = true
    }
}
