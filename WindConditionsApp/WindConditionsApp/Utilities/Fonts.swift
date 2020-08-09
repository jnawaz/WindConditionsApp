//
// Created by Jamil Nawaz on 09/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

enum Font: CaseIterable {
    case regular
    case medium
    case semiBold
    case bold
    case extraBold
    case black
    case italic

    func withSize(_ size: CGFloat) -> UIFont {

        switch self {
        case .regular:
            return UIFont(name: "Montserrat-Regular", size: size)!
        case .medium:
            return UIFont(name: "Montserrat-Medium", size: size)!
        case .semiBold:
            return UIFont(name: "Montserrat-SemiBold", size: size)!
        case .bold:
            return UIFont(name: "Montserrat-Bold", size: size)!
        case .extraBold:
            return UIFont(name: "Montserrat-ExtraBold", size: size)!
        case .black:
            return UIFont(name: "Montserrat-Black", size: size)!
        case .italic:
            return UIFont(name: "Montserrat-Italic", size: size)!
        }

    }
}