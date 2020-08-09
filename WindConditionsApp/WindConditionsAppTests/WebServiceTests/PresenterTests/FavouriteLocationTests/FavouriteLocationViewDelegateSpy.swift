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

    func showEmptyFavouritesView() {
        shouldShowEmptyFavouritesView = true
    }

    func hideEmptyFavouritesView() {
        shouldHideEmptyFavouritesView = true
    }
}
