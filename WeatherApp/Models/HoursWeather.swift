//
//  HoursWeather.swift
//  WeatherApp
//
//  Created by Artem Mazur on 15.03.2022.
//

import Foundation

struct HoursWeather: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let hourly: [Hourly]
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}

struct HoursTemp: Codable {
    let day: Double
}
