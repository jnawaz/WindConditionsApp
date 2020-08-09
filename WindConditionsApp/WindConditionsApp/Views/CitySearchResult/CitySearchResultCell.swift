//
//  CitySearchResultCell.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class CitySearchResultCell: UITableViewCell {

    @IBOutlet var searchResultLabel: UILabel!

    static let identifier = "SearchCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setLabel(with city: City) {
        var labelText = ""
        if let cityName = city.name, let stateName = city.state, let countryCode = city.country {
            if stateNameIsEmpty(stateName: stateName) {
                labelText = "\(cityName) - \(countryCode)"
            } else {
                labelText = "\(cityName), \(stateName) - \(countryCode)"
            }
        }
        searchResultLabel.text = labelText
    }

    private func stateNameIsEmpty(stateName: String) -> Bool {
        stateName == ""
    }
}
