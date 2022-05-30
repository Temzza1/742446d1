//
//  SecondViewModel.swift
//  WeatherApp
//
//  Created by Artem Mazur on 4/3/22.
//

import Foundation
import CoreLocation

protocol SecondViewModelDelegate: AnyObject {
    func openViewController()
}

class SecondViewModel {
    
    var delegate: SecondViewModelDelegate?
    let viewControllerManager = ViewControllerManager.shared
    var dailyDataSource = ViewControllerManager.shared.dailyWeather.asObservable()
    
    func openViewController() {
        delegate?.openViewController()
    }
    
    func fetchDailyForecast() {
        viewControllerManager.dailyForecastFetchRequest()
        self.viewControllerManager.factGeoWeather.accept(false)
    }
    
}

