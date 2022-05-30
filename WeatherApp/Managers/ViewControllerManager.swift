//
//  ViewControllerManager.swift
//  WeatherApp
//
//  Created by Artem Mazur on 20.02.2022.
//

import Foundation
import CoreLocation
import Alamofire
import UIKit
import RxSwift
import RxCocoa

class ViewControllerManager {
    
    static let shared = ViewControllerManager()
    private init() {}
    
    let keys = Keys()
    
    var locationManager = CLLocationManager()
    var geoLocation = CLLocationCoordinate2D()
    var geoLongitude = BehaviorRelay<Double>(value: 0)
    var geoLatitude = BehaviorRelay<Double>(value: 0)
    var currentWeather = BehaviorRelay<CurrentWeather?>(value: nil)
    var cityList = BehaviorRelay<[City]>(value: [])
    var hours = BehaviorRelay<[Hourly]>(value: [])
    var hourly = BehaviorRelay<HoursWeather?>(value: nil)
    var dailyWeather = BehaviorRelay<[DailyInfo]>(value: [])
    var cityName = BehaviorRelay<String>(value: "")
    var factGeoWeather = BehaviorRelay<Bool>(value: true)
    
    
    func getLocation(_ locationManager: CLLocationManager) {
        
        if self.factGeoWeather.value == true {
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
            guard let location = locationManager.location?.coordinate else { return }
            self.geoLocation = location
            self.factGeoWeather.accept(false)
        }
    }
    
    func checkGeoStatus() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        guard let location = locationManager.location?.coordinate else { return }
        self.geoLocation = location
    }
    
    func currentForecastFetchRequest()  {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(self.geoLocation.latitude)&lon=\(self.geoLocation.longitude)&lang=en&units=metric&appid=\(self.keys.openWeatherKey)"
        AF.request(url).responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let result):
                self.currentWeather.accept(result)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func hourlyForecastFetchRequest()  {
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(self.geoLocation.latitude)&lon=\(self.geoLocation.longitude)&lang=en&units=metric&exclude=minutely,daily,alerts&appid=\(self.keys.openWeatherKey)"
        AF.request(url).responseDecodable(of: HoursWeather.self) { response in
            switch response.result {
            case .success(let result):
                self.hours.accept(result.hourly)
                self.hourly.accept(result)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func dailyForecastFetchRequest()  {
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(self.geoLocation.latitude)&lon=\(self.geoLocation.longitude)&lang=en&units=metric&exclude=minutely,hourly,alerts&appid=\(self.keys.openWeatherKey)"
        AF.request(url).responseDecodable(of: DailyWeather.self) { response in
            switch response.result {
            case .success(let result):
                self.dailyWeather.accept(result.daily)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func fetchRequestFromSearch(cityName: String) {
        let editedCityName = cityName.replacingOccurrences(of: " ", with: "%20")
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(editedCityName)&lang=en&units=metric&appid=\(self.keys.openWeatherKey)"
        AF.request(url).responseDecodable(of: CurrentWeather.self) { response in
            switch response.result {
            case .success(let result):
                self.currentWeather.accept(result)
                self.geoLocation.latitude = result.coord?.lat ?? 0
                self.geoLocation.longitude = result.coord?.lon ?? 0
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func parseJSONCityList() {
        guard let path = Bundle.main.path(forResource: "cityNameList", ofType: "json") else { return }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let citiesInfo = try JSONDecoder().decode(CityNameList.self, from: data)
            self.cityList.accept(citiesInfo.city)
        } catch {
            print(error.localizedDescription)
        }

    }
    
    
    
    func checkLocatinServicesAuth(_ locationManager: CLLocationManager, vc: UIViewController) {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case  .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .denied, .restricted:
                let alert = UIAlertController(title: "Allow Location Access", message: "MyApp needs access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)")
                        })
                    }
                }))
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                    return
                }))
                
                vc.present(alert, animated: true, completion: nil)
                
                break
            case .authorizedWhenInUse, .authorizedAlways:
                self.checkGeoStatus()
                break
            @unknown default:
                fatalError()
            }
        }
    }
    
    
    
    
    
}
