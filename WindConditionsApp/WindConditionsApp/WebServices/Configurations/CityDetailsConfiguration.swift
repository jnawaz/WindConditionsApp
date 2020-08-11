//
// Created by Jamil Nawaz on 09/08/2020.
// Copyright (c) 2020 Jamil Nawaz. All rights reserved.
//

import Foundation
import UIKit

struct CityDetailsConfiguration: WebServiceConfiguration {
    typealias Response = CityDetailsResponse
    var networkManager: NetworkManager = NetworkManager()
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
            URLQueryItem(name: "exclude", value: exclude),
            URLQueryItem(name: "appId", value: apiKey)
        ]
    }

}

struct CityDetailsResponse: Decodable {
    let lat: Float?
    let lon: Float?
    let timezone: String?
    let timezone_offset: Int?
    let current: Forecast?
    let daily: [DailyBreakdown]?
}

struct Forecast: Decodable {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Float?
    let feels_like: Float?
    let pressure: Int?

    let humidity: Int?
    let dew_point: Float?
    let uvi: Float?
    let clouds: Int?
    let visibility: Int?
    let wind_speed: Float?
    let wind_deg: Int?
    let weather: [Weather]?

    func windDegreesFormatted() -> String {
        if let windDegrees = wind_deg {
            return String(windDegrees) + "°"
        }
        return ""
    }

    func windRotationAngle() -> CGFloat {
        if let windDegrees = wind_deg {
            let northPoint: CGFloat = 360.0
            if windDegrees == 0 {
                return northPoint
            }
            return northPoint - CGFloat(windDegrees)
        }
        return .zero
    }
}

struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct DailyBreakdown: Decodable {
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
    let pop: Float?
    let uvi: Float?

    func windSpeedFormatted() -> String? {
        if let windSpeed = wind_speed {
            let speed = String(windSpeed)
            return speed
        }
        return ""
    }

    func windDegreesFormatted() -> String? {
        if let windDegrees = wind_deg {
            return String(windDegrees) + "°"
        }
        return ""
    }


    func dateAsShortFormat() -> String? {
        if let dailyDate = dt {
            let date = Date(timeIntervalSince1970: TimeInterval(dailyDate))
            return date.toShortFormat()
        }

        return ""
    }
}

struct DailyTemperatures: Decodable {
    let day: Float?
    let min: Float?
    let max: Float?
    let night: Float?
    let eve: Float?
    let morn: Float?
}

struct FeelsLike: Decodable {
    let day: Float?
    let night: Float?
    let eve: Float?
    let morn: Float?
}

struct WeatherDescription: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}