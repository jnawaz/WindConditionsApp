//
// Created by Jamil Nawaz on 10/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation

extension Date {

    var calendar: Calendar {
        return NSCalendar.current
    }

    public func toShortFormat() -> String {
        var dateString = ""

        let dateComponents = calendar.dateComponents([.day, .month, .year], from: self)
        dateString = "\(dateComponents.day!)-\(dateComponents.month!)-\(dateComponents.year!)"

        return dateString
    }
}