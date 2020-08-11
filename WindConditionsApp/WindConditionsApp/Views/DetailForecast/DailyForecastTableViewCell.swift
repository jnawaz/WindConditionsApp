//
//  DailyForecastTableViewCell.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 11/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windDegreeLabel: UILabel!

    static let Identifier = "DailyForecastCell"
    static let heightForRow: CGFloat = 140.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(dailyForecast: DailyBreakdown) {
        self.dateLabel.text = "Date: \(dailyForecast.dateAsShortFormat()!)"
        self.windSpeedLabel.text = "Wind speed: \(dailyForecast.windSpeedFormatted()!)"
        self.windDegreeLabel.text = "Degrees: \(dailyForecast.windDegreesFormatted()!)"
    }
}
