//
// Created by Jamil Nawaz on 08/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation

class FileHelper {

    func data(from filename: String, type: String) -> Data? {
        if let path = Bundle.main.path(forResource: filename, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return nil
            }
        }
        return nil
    }
}
