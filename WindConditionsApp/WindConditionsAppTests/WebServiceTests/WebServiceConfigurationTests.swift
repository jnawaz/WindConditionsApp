//
//  WebServiceConfigurationTests.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 06/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import XCTest

class WebServiceConfigurationTests: XCTestCase {
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

            XCTAssertTrue(request.httpMethod == sut.method.rawValue)

            XCTAssertTrue(headerFields[apiKeyHeader] == apiKey)

            XCTAssertEqual(request.httpBody, sut.requestBody)
        }

        sut.start { _ in }
    }

}
