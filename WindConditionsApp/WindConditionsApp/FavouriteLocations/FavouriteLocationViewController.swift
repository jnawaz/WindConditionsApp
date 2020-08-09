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
    @IBOutlet var addNewCityInstructionView: UIView!
    @IBOutlet var addNewCityInstructionTitle: UILabel!
    @IBOutlet var addNewCityInstructionBody: UILabel!

    var presenter: FavouriteLocationPresenter?
    var searchCityResults: [City]?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavouriteLocationPresenter(viewDelegate: self, managedObjectContext: CoreDataStack().mainContext)
        presenter?.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.view.backgroundColor = Colors.emptyFavouritesBackground
        noFavouritesSearchTableView.backgroundColor = Colors.emptyFavouritesBackground
        addNewCityInstructionView.backgroundColor = Colors.emptyFavouritesBackground
        addNewCityInstructionTitle.text = localizedString(key: "NoFavouritesAdded.Title")
        addNewCityInstructionBody.text = localizedString(key: "NoFavouritesAdded.Body")
        noFavouritesSearchBar.placeholder = localizedString(key: "NoFavouritesSearchBarPlaceHolder")
        noFavouritesSearchBar.tintColor = Colors.noFavouritesSearchBarTint
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
        presenter?.searchFor(city: searchText, completionHandler: { cities in

            self.searchCityResults = nil
            self.noFavouritesSearchTableView.reloadData()

            if let citiesResult = cities {
                self.searchCityResults = citiesResult
                self.noFavouritesSearchTableView.reloadData()
            }

        })
    }
}

// MARK: - UITableView Methods
extension FavouriteLocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchCityResults?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = CitySearchResultCell.identifier
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? CitySearchResultCell
        if cell == nil {
            cell = CitySearchResultCell(style: .default, reuseIdentifier: reuseIdentifier) as CitySearchResultCell
        }

        var labelText = ""
        guard var city = searchCityResults?[indexPath.row] else { return UITableViewCell() }
        cell?.setLabel(with: city)

        return cell!
    }
}
