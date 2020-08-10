//
//  DateTests.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 10/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import XCTest
@testable import WindConditionsApp
import Foundation

class DateTests: XCTestCase {

    func testUnixDateConversion() {
        let unixTimeStamp: Double = 1597084959
        let date = Date(timeIntervalSince1970: unixTimeStamp)

        let calendar = NSCalendar.current
        let dateComponents = calendar.dateComponents([.day, .month, .year], from: date)

        XCTAssertEqual(dateComponents.day, 10)
        XCTAssertEqual(dateComponents.month, 8)
        XCTAssertEqual(dateComponents.year, 2020)
    }

    func testDateToDayAndMonth() {
        let unixTimeStamp: Double = 1597084959
        let date = Date(timeIntervalSince1970: unixTimeStamp)

        let dateString = date.toShortFormat()

        XCTAssertEqual(dateString, "10th August 2020")
    }

}
