//
//  FavoriteListViewModel.swift
//  WeatherApp
//
//  Created by Artem Mazur on 5/22/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol FavoriteListViewModelDelegate: AnyObject {
    func openFavoriteList()
}

class FavoriteListViewModel {
    
    let viewControllerManager = ViewControllerManager.shared
    var delegate: FavoriteListViewModelDelegate?
    var disposeBag = DisposeBag()
    var cityList = ViewControllerManager.shared.cityList.asObservable()
    var cityNameChanged = ViewControllerManager.shared.cityName.asObservable()
    
    func getCityList() {
        self.viewControllerManager.cityName.accept(self.viewControllerManager.currentWeather.value?.name ?? "")
        self.viewControllerManager.parseJSONCityList()
    }
    
    func fetchCurrentListForecast() {
        if  self.viewControllerManager.factGeoWeather.value == false {
            self.viewControllerManager.fetchRequestFromSearch(cityName: viewControllerManager.cityName.value)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.viewControllerManager.currentForecastFetchRequest()
                self.viewControllerManager.hourlyForecastFetchRequest()
            }
            
            
        }
    }
    
    func fetchSearchCity(with textField: UITextField, completion: @escaping () -> ()) {
        textField.rx
            .controlEvent(.editingDidEndOnExit)
            .withLatestFrom(textField.rx.text.orEmpty)
            .bind(onNext: { text in
                self.viewControllerManager.cityName.accept(text.lowercased())
                self.viewControllerManager.factGeoWeather.accept(false)
                completion()
                self.fetchCurrentListForecast()
            }).disposed(by: disposeBag)
    }
    
    func cityNameChanged(completion: @escaping () -> ()) {
        self.cityNameChanged.subscribe(onNext: { city in
            if !city.isEmpty {
                completion()
            }
        }).disposed(by: disposeBag)
    }
}
