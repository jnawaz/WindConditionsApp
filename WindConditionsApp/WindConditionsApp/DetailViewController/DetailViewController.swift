//
//  DetailViewController.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailViewDelegate {

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
    }

}
