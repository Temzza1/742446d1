//
//  HoursCellModel.swift
//  WeatherApp
//
//  Created by Artem Mazur on 4/11/22.
//

import Foundation
import UIKit

class HoursCellModel {
    
    let viewControllerManager = ViewControllerManager.shared
    // value for HourlyForecast
    var hourlyDataSource = ViewControllerManager.shared.hours.asObservable()
    
}


