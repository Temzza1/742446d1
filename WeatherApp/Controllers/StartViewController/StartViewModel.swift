//
//  StartViewModel.swift
//  WeatherApp
//
//  Created by Artem Mazur on 5/30/22.
//

import UIKit
import CoreLocation

class StartViewModel {
    
    let viewControllerManager = ViewControllerManager.shared
    var locationManager = CLLocationManager()
    
    func preLoadingWeather() {
        self.viewControllerManager.currentForecastFetchRequest()
        self.viewControllerManager.hourlyForecastFetchRequest()
        
    }
}
                                                            
