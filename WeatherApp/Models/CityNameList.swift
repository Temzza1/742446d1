//
//  CityNameList.swift
//  WeatherApp
//
//  Created by Artem Mazur on 5/23/22.
//

import Foundation

// MARK: - CityNameList
struct CityNameList: Decodable {
    let city: [City]
}

// MARK: - City
struct City: Decodable {
    let country, name: String
}

