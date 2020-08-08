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

    // MARK: - Request
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

    // MARK: - Errors
    func testHandlesConnectionError() {
        let (sut, mock) = generateExampleWebServiceConfiguration()
        mock.error = NSError(domain: "", code: NSURLErrorNotConnectedToInternet, userInfo: nil)

        sut.start { responseType in
            switch responseType {
            case .success:
                XCTFail("This should not be a success")
            case .failure(let error as WebServiceError):
                XCTAssertEqual(error, .noInternetError)
            case .failure(_):
                XCTFail("This should have failed as a no internet error")
            }
    }

    func testHandlesCancelledError() {}

    func testHandlesUnknownError() {}

    // MARK: - Invalid responses
    func testHandlesNoStatusCode() {}

    func testHandlesNoData() {}

    func testHandlesDecodeError() {}

    // MARK: - 400 Errors
    func testHandles400StatusCode() {}

    func testHandles401StatusCode() {}

    func testHandles403StatusCode() {}
}
