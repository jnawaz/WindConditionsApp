//
//  FavouriteLocationViewController.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class FavouriteLocationViewController: UIViewController, FavouriteLocationViewDelegate {
    var presenter: FavouriteLocationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavouriteLocationPresenter(viewDelegate: self, managedObjectContext: CoreDataStack().mainContext)
        presenter?.viewDidLoad()
    }

    //MARK: - View Delegate Methods

    func showEmptyFavouritesView() {
        //TODO: Implement method
    }

    func hideEmptyFavouritesView() {
        //TODO: Implement method
    }

    func showLoadingIndicator() {
        self.showLoadingIndicatorView()
    }

    func hideLoadingIndicator() {
        self.hideLoadingIndicatorView()
    }
}
