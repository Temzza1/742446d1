//
//  NewViewModel.swift
//  WeatherApp
//
//  Created by Artem Mazur on 4/3/22.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

protocol ViewControllerModelDelegate {
    func presentWeekForecast()
}

class ViewControllerViewModel {
    
    var delegate: ViewControllerModelDelegate?
    let locationManager = CLLocationManager()
    let viewControllerManager = ViewControllerManager.shared
    var currentDataSource = ViewControllerManager.shared.currentWeather.asObservable()
    
    
    
    func presentWeekForecast() {
        delegate?.presentWeekForecast()
    }
    
    
    func fetch() {
        if self.viewControllerManager.factGeoWeather.value == true {
            viewControllerManager.getLocation(locationManager)
            viewControllerManager.currentForecastFetchRequest()
            viewControllerManager.hourlyForecastFetchRequest()
            viewControllerManager.factGeoWeather.accept(false)
        }
    }
    
    func checkCoreLocationStatus(_ locationManager: CLLocationManager, vc: ViewController) {
        if self.viewControllerManager.factGeoWeather.value == false {
            viewControllerManager.checkLocatinServicesAuth(locationManager, vc: vc)
        } else {
            return
        }
    }
    
}
