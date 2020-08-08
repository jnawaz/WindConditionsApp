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

   func testCityCreation() {
       let city = City(context: testContext)

       do {
           try testContext.save()
       } catch {
           XCTFail("Failed to create and save city object")
       }
   }
}
