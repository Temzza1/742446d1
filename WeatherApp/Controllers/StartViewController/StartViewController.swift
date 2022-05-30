//
//  StartViewController.swift
//  WeatherApp
//
//  Created by Artem Mazur on 5/30/22.
//

import UIKit
import CoreLocation

class StartViewController: UIViewController {

    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    var viewModel = StartViewModel()
    weak var coordinator: Coordinator?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

}

extension StartViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.coordinator?.eventHappended(with: .openMainController)
        self.viewModel.preLoadingWeather()
        locationManager.stopUpdatingLocation()
    }
    
}
