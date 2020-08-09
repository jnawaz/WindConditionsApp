//
//  FavouriteLocationViewDelegateSpy.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class FavouriteLocationViewDelegateSpy: FavouriteLocationViewDelegate {
    var shouldShowEmptyFavouritesView = false
    var shouldHideEmptyFavouritesView = false
    var shouldShowLoadingIndicator = false
    var shouldHideLoadingIndicator = false
    var shouldShowFavouritesView = false

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
}
