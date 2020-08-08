//
//  CityTests.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 08/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import XCTest
import CoreData

@testable import WindConditionsApp

class CityTests: XCTestCase {

    private let testContext = CoreDataTestStack().mainContext

    func testNoCities() {
        var cities: Int = -1
        let citiesRequest = NSFetchRequest<NSManagedObject>(entityName: "City")
        do {
            cities = try testContext.fetch(citiesRequest).count
        } catch {
            XCTFail("Failed to fetch cities")
        }
        XCTAssertEqual(cities, 0)
    }

    func testAddingCityCoordinates() {
        let city = newCity()
        let coordinates = Coordinates(context: testContext)
        coordinates.longitude = 1.09
        coordinates.latitude = 1.10
        city.coordinates = coordinates

        XCTAssertEqual(city.coordinates?.latitude, coordinates.latitude)
        XCTAssertEqual(city.coordinates?.longitude, coordinates.longitude)
    }

    func newCity() -> City {
        return City(context: testContext)
    }
}
