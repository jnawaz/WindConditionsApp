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

    private let failureExpectation = "This should have failed to be a success"
    private let expectedFailureForOtherReason = "This should have failed for a different reason"

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

        sut.start { response in
            switch response {
            case .success:
                XCTFail(self.failureExpectation)
            case .failure(let error as WebServiceError):
                XCTAssertEqual(error, .noInternetError)
            case .failure:
                XCTFail(self.expectedFailureForOtherReason)
            }
        }
    }

    func testHandlesCancelledError() {
        let (sut, mock) = generateExampleWebServiceConfiguration()
        mock.error = NSError(domain: "", code: NSURLErrorCancelled, userInfo: nil)

        sut.start { response in
            switch response {
            case .success:
                XCTFail(self.failureExpectation)
            case .failure(let error as WebServiceError):
                XCTAssertEqual(error, .cancelled)
            case .failure:
                XCTFail(self.expectedFailureForOtherReason)
            }
        }
    }

    func testHandlesUnknownError() {
        let (sut, mock) = generateExampleWebServiceConfiguration()
        mock.error = NSError(domain: "", code: NSURLErrorUnknown, userInfo: nil)

        sut.start { response in
            switch response {
            case .success:
                XCTFail(self.failureExpectation)
            case .failure(let error as WebServiceError):
                XCTAssertEqual(error, .networkingError)
            case .failure:
                XCTFail(self.expectedFailureForOtherReason)
            }
        }
    }

    // MARK: - Invalid responses
    func testHandlesNoStatusCode() {
        let (sut, _) = generateExampleWebServiceConfiguration()

        sut.start { responseType in
            switch responseType {
            case .success:
                XCTFail(self.failureExpectation)
            case .failure(let error as WebServiceError):
                XCTAssertEqual(error, .invalidResponse(debugDescription: "Failed to parse HTTP status code"))
            case .failure:
                XCTFail(self.expectedFailureForOtherReason)
            }
        }
    }

    func testHandlesNoData() {
        let (sut, mock) = generateExampleWebServiceConfiguration()

        let response = HTTPURLResponse(url: sut.baseUrl, statusCode: 200, httpVersion: nil, headerFields: nil)
        mock.response = response

        sut.start { response in
            switch response {
            case .success:
                XCTFail(self.failureExpectation)
            case .failure(let error as WebServiceError):
                XCTAssertEqual(error, .invalidResponse(debugDescription: "Response data was nil"))
            case .failure:
                XCTFail(self.expectedFailureForOtherReason)
            }
        }
    }

    func testHandlesDecodeError() {
    }

    // MARK: - 400 Errors
    func testHandles400StatusCode() {}

    func testHandles401StatusCode() {}

    func testHandles403StatusCode() {}
}
