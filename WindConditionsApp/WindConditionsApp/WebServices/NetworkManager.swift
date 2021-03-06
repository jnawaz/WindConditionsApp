//
// Created by Jamil Nawaz on 06/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation

import Foundation

protocol NetworkSession {
    func loadData(from request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSession {

    func loadData(from request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
}

class NetworkManager {
    private let session: NetworkSession

    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }

    func request(_ request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        session.loadData(from: request, completionHandler: completion)
    }
}
