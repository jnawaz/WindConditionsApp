//
// Created by Jamil Nawaz on 06/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation
@testable import WindConditionsApp

class URLSessionMock: NetworkSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    var willRequest: ((URLRequest) -> Void)?

    func loadData(from request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        willRequest?(request)
        DispatchQueue.global().async { [weak self] in
            completionHandler(self?.data, self?.response, self?.error)
        }
    }
}
