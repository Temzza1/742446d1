//
//  DailyCellModel.swift
//  WeatherApp
//
//  Created by Artem Mazur on 4/11/22.
//

import Foundation

class DailyCellModel {
    
    var dailyDataSource = ViewControllerManager.shared.dailyWeather.asObservable()
    
}
