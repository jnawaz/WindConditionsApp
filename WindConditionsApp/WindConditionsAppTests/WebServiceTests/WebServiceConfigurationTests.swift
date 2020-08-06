//
//  WebServiceConfigurationTests.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 06/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import XCTest
@testable import WindConditionsApp

class WebServiceConfigurationTests: XCTestCase {

    struct ExampleWebServiceConfiguration: WebServiceConfiguration {
        typealias Response = [String]
        let query: String
        let method: HTTPMethod = .post
        let networkManager: NetworkManager
        var pathComponents: [String] {
            return ["test", query]
        }
    }

    func generateExampleWebServiceConfiguration(query: String = "someQuery") -> (webServiceConfiguration: ExampleWebServiceConfiguration, mock: URLSessionMock) {
        let mock = URLSessionMock()
        let networkManager = NetworkManager(session: mock)
        return (ExampleWebServiceConfiguration(query: query, networkManager: networkManager), mock)
    }

    func testsRequestSetupCorrectly() {
        let (sut, mock) = generateExampleWebServiceConfiguration()

        mock.willRequest = { request in
            guard let urlString = request.url?.absoluteString
                    else { return }

            sut.pathComponents.forEach {
                XCTAssertTrue(urlString.contains($0))
            }

            XCTAssertEqual(request.httpMethod, sut.method.rawValue)
        }

        sut.start { _ in }
    }

}
