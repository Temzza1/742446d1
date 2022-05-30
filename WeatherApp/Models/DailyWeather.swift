//
//  WeatherMain.swift
//  WeatherApp
//
//  Created by Artem Mazur on 08.03.2022.
//

import Foundation


// MARK: - Empty
struct DailyWeather: Codable {
    let lat: Double
    let lon: Double
    let daily: [DailyInfo]
    
}


// MARK: - Weather
struct DailyDecrip: Codable {
    let weatherDescription: String
    let icon: String
}

// MARK: - Daily
struct DailyInfo: Codable {
    let dt: Int
    let temp: DailyTemp
    let weather: [Weather]
}

// MARK: - Temp
struct DailyTemp: Codable {
    let min: Double
    let max: Double
}
