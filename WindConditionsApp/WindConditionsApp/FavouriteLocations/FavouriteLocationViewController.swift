//
//  FavouriteLocationViewController.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class FavouriteLocationViewController: UIViewController {
    @IBOutlet var noFavouritesSearchBar: UISearchBar!
    @IBOutlet var noFavouritesSearchTableView: UITableView!
    @IBOutlet var addNewCityInstructionView: UIView!
    @IBOutlet var addNewCityInstructionTitle: UILabel!
    @IBOutlet var addNewCityInstructionBody: UILabel!
    @IBOutlet var emptyFavourtiesView: UIView!
    @IBOutlet var savedFavouritesTableView: UITableView!

    var presenter: FavouriteLocationPresenter?
    var searchCityResults: [City]?

    var selectedCity: AbstractCity?
    var selectedCityAPIResponse: CityDetailsResponse?

    private var favouriteCities: [FavouriteCities]?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavouriteLocationPresenter(viewDelegate: self, managedObjectContext: CoreDataStack().mainContext)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
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
        savedFavouritesTableView.backgroundColor = Colors.favouritesTableBackgroundColor
    }
}

//Mark: - Delegate Methods
extension FavouriteLocationViewController: FavouriteLocationViewDelegate {

    //MARK: - View Delegate Methods
    func showEmptyFavouritesView() {
    }

    func hideEmptyFavouritesView() {
        self.addNewCityInstructionView.isHidden = false
        self.savedFavouritesTableView.isHidden = true
        self.view.bringSubviewToFront(self.addNewCityInstructionView)
    }

    func showLoadingIndicator() {
        self.showLoadingIndicatorView()
    }

    func hideLoadingIndicator() {
        self.hideLoadingIndicatorView()
    }

    func showFavouritesView(favCities: [FavouriteCities]) {
        self.addNewCityInstructionView.isHidden = true
        self.view.bringSubviewToFront(self.savedFavouritesTableView)

        self.favouriteCities = favCities
        self.savedFavouritesTableView.reloadData()

    }

    func showAddCityInstructionView() {
        self.addNewCityInstructionView.isHidden = false
        self.savedFavouritesTableView.isHidden = true
        self.view.bringSubviewToFront(self.addNewCityInstructionView)
    }

    func showFavouritesView() {
        self.addNewCityInstructionView.isHidden = true
        self.savedFavouritesTableView.isHidden = false
    }

    func showSearchResultsTable() {
        self.noFavouritesSearchTableView.isHidden = false
        self.savedFavouritesTableView.isHidden = true
        self.view.bringSubviewToFront(self.noFavouritesSearchTableView)
    }

}

//MARK: - UISearchBar Methods
extension FavouriteLocationViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.isSearching = true
        if searchText == "" {
            presenter?.isSearching = false
        }
        presenter?.searchFor(city: searchText, completionHandler: { cities in
            self.searchCityResults = nil
            self.noFavouritesSearchTableView.reloadData()

            self.presenter?.configureViews()

            if let citiesResult = cities {
                self.searchCityResults = citiesResult
                self.noFavouritesSearchTableView.reloadData()
                self.addNewCityInstructionView.isHidden = true
            }
        })
    }
}

// MARK: - UITableView Methods
extension FavouriteLocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch tableView {
        case self.noFavouritesSearchTableView:
            return self.searchCityResults?.count ?? 0

        case self.savedFavouritesTableView:
            return favouriteCities?.count ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var reuseIdentifier: String

        switch tableView {
        case self.noFavouritesSearchTableView:
            reuseIdentifier = CitySearchResultCell.identifier
        case self.savedFavouritesTableView:
            reuseIdentifier = AddedFavouritesCell.identifier
        default:
            reuseIdentifier = ""
        }

        var cell: UITableViewCell

        switch tableView {
        case self.noFavouritesSearchTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CitySearchResultCell
            if cell == nil {
                cell = CitySearchResultCell(style: .default, reuseIdentifier: reuseIdentifier) as CitySearchResultCell
            }

            var labelText = ""
            guard var city = searchCityResults?[indexPath.row] else {
                return UITableViewCell()
            }
            (cell as! CitySearchResultCell).setLabel(with: city)

        case self.savedFavouritesTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! AddedFavouritesCell
            if cell == nil {
                cell = AddedFavouritesCell(style: .default, reuseIdentifier: reuseIdentifier) as AddedFavouritesCell
            }

            guard var favouriteCity = favouriteCities?[indexPath.row] else {
                return UITableViewCell()
            }

            (cell as! AddedFavouritesCell).configure(with: favouriteCity)

        default:
            return UITableViewCell()

        }
        return cell
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        return UIView(frame: frame)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        var selectedCity: AbstractCity
        switch tableView {
        case self.savedFavouritesTableView:
            selectedCity = self.favouriteCities![indexPath.row]
        case self.noFavouritesSearchTableView:
            selectedCity = searchCityResults![indexPath.row]
        default:
            fatalError("Should not have hit this")
        }

        if let coordinates = selectedCity.coordinates {
            CityDetailsConfiguration(lat: String(coordinates.latitude), lon: String(coordinates.longitude), exclude: "minutely,hourly")
                    .start { result in
                        switch result {
                        case .success(let apiResponse):
                            self.selectedCity = selectedCity as? AbstractCity
                            self.selectedCityAPIResponse = apiResponse
                            self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: nil)
                        case .failure:
                            self.presentAlert(
                                    title: localizedString(key: "APIError.Title"),
                                    message: localizedString(key: "CityDetailsResponse.Error")
                            )
                        }
                    }
        }
    }
}

//MARK: - Navigation
extension FavouriteLocationViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is DetailViewController {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.apiResponse = self.selectedCityAPIResponse
            detailViewController.city = (self.selectedCity ?? nil) as AbstractCity
        }
    }
}
