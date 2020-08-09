//
// Created by Jamil Nawaz on 09/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation

struct CityDetailsConfiguration: WebServiceConfiguration {
    typealias Response = CityDetailsResponse

    var lat: String?
    var lon: String?
    var exclude: String?

    var pathComponents: [String] {
        return ["onecall"]
    }
    var queryParameters: [URLQueryItem]? {
        guard let lat = lat,
              let lon = lon,
              let exclude = exclude else {
            return nil
        }

        return [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "lat", value: exclude)
        ]
    }

}

struct CityDetailsResponse {
    let lat: Float?
    let lon: Float?
    let timezone: String?
    let timezone_offset: String?
    let current: Forecast?
    let daily: [DailyBreakdown]?

}

struct Forecast {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Float?
    let feels_like: Float?
    let pressure: Int?
    let humidity: Int?
    let dew_point: Int?
    let uvi: Float?
    let clouds: Int?
    let visibility: Int?
    let wind_speed: Float?
    let wind_deg: Int?
    let weather: Weather?
}

struct Weather {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct DailyBreakdown {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: DailyTemperatures?
    let feels_like: FeelsLike?
    let pressure: Int?
    let humidity: Int?
    let dew_point: Float?
    let wind_speed: Float?
    let wind_deg: Int?
    let weather: [WeatherDescription]?
    let clouds: Int?
    let pop: Int?
    let uvi: Float?
}

struct DailyTemperatures {
    let day: Float?
    let min: Float?
    let max: Float?
    let night: Float?
    let eve: Float?
    let morn: Float?
}

struct FeelsLike {
    let day: Float?
    let night: Float?
    let eve: Float?
    let morn: Float?
}

struct WeatherDescription {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}