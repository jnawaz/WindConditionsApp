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

    func testOnViewDidLoadNoCitiesShouldShowEmptyFavourtiesView() {
        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.viewDidLoad()

        XCTAssertTrue(viewDelegate.shouldShowEmptyFavouritesView)
    }

    func testOnViewDidLoadHasCitiesDataShouldHideEmptyFavouritesView() {
        let city = NSEntityDescription.insertNewObject(forEntityName: "City", into: testContext) as! City
        do {
            try testContext.save()
        } catch {
            XCTFail("Shouldn't fail here")
        }

        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.viewDidLoad()

        XCTAssertTrue(viewDelegate.shouldHideEmptyFavouritesView)
    }

    func testOnViewDidLoadWhilstPopulatingCityDataShowsLoadingIndicatorView() {
        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.viewDidLoad()

        XCTAssertTrue(viewDelegate.shouldShowLoadingIndicator)
    }

    func testOnViewDidLoadCityDataExistsShouldNotShowLoadingIndicator() {
        let city = NSEntityDescription.insertNewObject(forEntityName: "City", into: testContext) as! City
        do {
            try testContext.save()
        } catch {
            XCTFail("Shouldn't fail here")
        }

        let presenter = FavouriteLocationPresenter(viewDelegate: viewDelegate, managedObjectContext: testContext)
        presenter.viewDidLoad()

        XCTAssertFalse(viewDelegate.shouldShowLoadingIndicator)
    }
}
