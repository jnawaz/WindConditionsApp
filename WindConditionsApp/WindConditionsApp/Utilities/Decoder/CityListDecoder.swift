//
// Created by Jamil Nawaz on 08/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation

let fileName = "citylist"
let fileType = "json"

struct CityStruct: Decodable {
    let id: Int?
    let name: String?
    let state: String?
    let country: String?
    let coord: CoordinatesStruct?
}

struct CoordinatesStruct: Decodable {
    let lon: Float
    let lat: Float
}

class CityListDecoder {
    func getCityData() -> [CityStruct]? {
        let cityListData = FileHelper().data(from: fileName, type: fileType)

        let decoder = JSONDecoder()
        if let cityData = cityListData {
            do {
                let cities = try decoder.decode([CityStruct].self, from: cityData)
                return cities
            } catch {
                fatalError("Failed to decode City list data")
            }
        }
        return nil
    }
}
