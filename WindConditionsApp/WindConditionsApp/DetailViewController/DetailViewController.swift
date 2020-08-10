//
//  DetailViewController.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailViewDelegate {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var windDirectionImage: UIImageView!
    @IBOutlet var windDirectionLabel: UILabel!

    var presenter: DetailPresenter?

    var city: City!
    var apiResponse: CityDetailsResponse!

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
        //TODO: Setup 5 day forecast view
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
}
