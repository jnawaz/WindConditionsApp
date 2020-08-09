//
//  FavouriteLocationViewController.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class FavouriteLocationViewController: UIViewController, FavouriteLocationViewDelegate {
    @IBOutlet var noFavouritesSearchBar: UISearchBar!
    @IBOutlet var noFavouritesSearchTableView: UITableView!

    var presenter: FavouriteLocationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavouriteLocationPresenter(viewDelegate: self, managedObjectContext: CoreDataStack().mainContext)
        presenter?.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.view.backgroundColor = Colors.emptyFavouritesBackground
        noFavouritesSearchTableView.backgroundColor = Colors.emptyFavouritesBackground
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

    func showFavouritesView() {
        // TODO: Implement method
    }
}

//MARK: - UISearchBar Methods
extension FavouriteLocationViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //TODO: Implement search
    }
}

// MARK: - UITableView Methods
extension FavouriteLocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* To implement */
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* To implement */
    }
}
