//
// Created by Jamil Nawaz on 09/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation
import UIKit

private struct ReferenceColors {

    static let lavender = UIColor("#E6EEF9")
}

struct Colors {
    static let emptyFavouritesBackground = ReferenceColors.lavender
}

extension UIColor {
    /// Must be in the format of #AARRGGBB or #RRGGBB (the function will correct pick up the AA components)
    convenience init(_ hexString: String) {

        if !(hexString.hasPrefix("#") && (hexString.count == 7 || hexString.count == 9)) {
            fatalError("Incorrect Hex String format")
        }

        let scanner = Scanner(string: hexString)
        // Skip #
        scanner.scanString("#", into: nil)

        var value: UInt32 = 0
        scanner.scanHexInt32(&value)

        var a: UInt32 = 0xFF
        if hexString.count == 9 {
            a = (value & 0xFF000000) >> 24
        }
        let r = (value & 0x00FF0000) >> 16
        let g = (value & 0x0000FF00) >> 8
        let b = (value & 0x000000FF) >> 0

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        let alpha = CGFloat(a) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}