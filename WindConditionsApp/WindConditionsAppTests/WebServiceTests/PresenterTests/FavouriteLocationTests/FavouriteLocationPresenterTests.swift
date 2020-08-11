//
//  FavouriteLocationPresenterTests.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 09/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import XCTest
import CoreData
@testable import WindConditionsApp

class FavouriteLocationPresenterTests: XCTestCase {

    var viewDelegate = FavouriteLocationViewDelegateSpy()
    let testContext = CoreDataTestStack().mainContext
    let notExpectingToFail = "Shouldn't fail here"

    func testOnViewDidLoadNoCitiesShouldShowEmptyFavourtiesView() {
        CoreDataTestStack().clearCoreDataStore()
        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.viewWillAppear()

        XCTAssertTrue(viewDelegate.shouldShowEmptyFavouritesView)
    }

    func testOnViewDidLoadHasCitiesDataShouldHideEmptyFavouritesView() {
        CoreDataTestStack().clearCoreDataStore()
        let city = NSEntityDescription.insertNewObject(forEntityName: "City", into: testContext) as! City
        do {
            try testContext.save()
        } catch {
            XCTFail(self.notExpectingToFail)
        }

        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.viewWillAppear()

        XCTAssertTrue(viewDelegate.shouldHideEmptyFavouritesView)
    }

    func testOnViewDidLoadWhilstPopulatingCityDataShowsLoadingIndicatorView() {
        CoreDataTestStack().clearCoreDataStore()
        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.viewWillAppear()

        XCTAssertTrue(viewDelegate.shouldShowLoadingIndicator)
    }

    func testOnViewDidLoadCityDataExistsShouldNotShowLoadingIndicator() {
        CoreDataTestStack().clearCoreDataStore()
        let city = NSEntityDescription.insertNewObject(forEntityName: "City", into: testContext) as! City
        do {
            try testContext.save()
        } catch {
            XCTFail(self.notExpectingToFail)
        }

        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.viewWillAppear()

        XCTAssertFalse(viewDelegate.shouldShowLoadingIndicator)
    }

    func testOnViewDidLoadUserHasFavouriteCitiesShouldShowFavouritesView() {
        CoreDataTestStack().clearCoreDataStore()
        let city = NSEntityDescription.insertNewObject(forEntityName: "City", into: testContext) as! City
        let favouriteCity = NSEntityDescription.insertNewObject(forEntityName: "FavouriteCities", into: testContext) as? FavouriteCities
        do {
            try testContext.save()
        } catch {
            XCTFail(self.notExpectingToFail)
        }

        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.viewWillAppear()

        XCTAssertTrue(viewDelegate.shouldShowFavouritesViewWithCities)
    }

    func testOnSearchForCityAndCityIsFoundShouldReturnCity() {
        let expectation = XCTestExpectation()
        CoreDataTestStack().clearCoreDataStore()
        let city = NSEntityDescription.insertNewObject(forEntityName: "City", into: testContext) as! City
        city.name = "test"

        do {
            try testContext.save()
        } catch {
            XCTFail(self.notExpectingToFail)
        }

        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.searchFor(city: "test", completionHandler: { cities in
            XCTAssertNotNil(cities)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 5.0)
    }
}
