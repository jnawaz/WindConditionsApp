//
//  DetailViewController.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var windDirectionImage: UIImageView!
    @IBOutlet var windDirectionLabel: UILabel!
    @IBOutlet var windForecastScrollView: UIScrollView!
    @IBOutlet var addToFavouritesButton: UIButton!

    var presenter: DetailPresenter?

    var city: AbstractCity!
    var apiResponse: CityDetailsResponse!
    var dailyBreakDown: DailyBreakdown!

    let fiveDayForecast = 5
    let dayOffset = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = DetailPresenter(viewDelegate: self, managedObjectContext: CoreDataStack().mainContext)
        setupUI()
    }

    private func setupUI() {
        if let cityName = city.name {
            self.title = cityName
        }
        self.view.backgroundColor = Colors.detailViewBackgroundColor
        setDateLabel()
        setWindDirectionLabel()
        transformWindDirectionImage()
        setupAddToFavouritesButton()
    }

    private func transformWindDirectionImage() {
        self.windDirectionImage.transform = CGAffineTransform(rotationAngle: self.apiResponse.current?.windRotationAngle() ?? 0)
    }

    private func setWindDirectionLabel() {
        self.windDirectionLabel.text = self.apiResponse.current?.windDegreesFormatted()
    }

    private func setDateLabel() {
        if let currentDate = self.apiResponse.current?.dt {
            let date = Date(timeIntervalSince1970: TimeInterval(currentDate))
            self.dateLabel.text = date.toShortFormat()
        }
    }

    private func setupAddToFavouritesButton() {
        self.addToFavouritesButton.setTitle(localizedString(key: "AddToFavouritesButtonTitle"), for: .normal)
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.Identifier) as? DailyForecastTableViewCell
        if cell == nil {
            cell = DailyForecastTableViewCell(style: .default, reuseIdentifier: DailyForecastTableViewCell.Identifier) as DailyForecastTableViewCell
        }
        if let dailyForecast = self.apiResponse.daily {
            dailyBreakDown = dailyForecast[indexPath.row + dayOffset]
        }
        cell?.configure(dailyForecast: dailyBreakDown)

        return cell!
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveDayForecast
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DailyForecastTableViewCell.heightForRow
    }
}

extension DetailViewController: DetailViewDelegate {
    func successfullySaved() {
        print("hello")
    }
    
    func failedToSave() {
        self.presentAlert(
                title: localizedString(key: "FavouriteSaveError.Title"), 
                message: localizedString(key: "FavouriteSaveError.Body")
        )
    }
}

// Mark: - Actions
extension DetailViewController {
    @IBAction func pressedAddToFavourites() {
        presenter?.addToFavourites(self.city as! City)
    }
}
