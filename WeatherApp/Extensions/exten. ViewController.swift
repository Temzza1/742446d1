//
//  exten. ViewController.swift
//  WeatherApp
//
//  Created by Artem Mazur on 20.02.2022.
//

import Foundation
import CoreLocation
import UIKit

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
  
    
}

extension ViewController: Storyboardable {}


