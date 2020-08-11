//
// Created by Jamil Nawaz on 11/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation
import UIKit

class AddedFavouritesCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    
    static let identifier = "AddedFavouriteCell"
    static let rowHeight: CFloat = 80.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with city: FavouriteCities) {
        if let name = city.name {
            self.cityName.text = name
        }
    }
}
