//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Artem Mazur on 20.02.2022.
//

import Foundation


struct CurrentWeather: Codable {

    let name: String?
    let timezone: Int
    let coord: Coord?
    let weather: [Weather]?
    let main: Main?
    let wind: Wind?
}

struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Codable {
    let temp: Double?
    let feels_like: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
}

struct Wind: Codable {
    let speed: Double?
}
