//
//  ViewController.swift
//  WeatherApp
//
//  Created by Artem Mazur on 16.02.2022.
//

import UIKit
import CoreLocation
import RxCocoa
import RxSwift

protocol ViewControllerDelegate: AnyObject {
    func bindCollectionData(with collection: UICollectionView)
}




class ViewController: UIViewController {
    
    
    @IBOutlet weak var containerViewMainWeather: UIView!
    @IBOutlet weak var containerViewWind: UIView!
    @IBOutlet weak var containerViewFeelsLike: UIView!
    @IBOutlet weak var containerViewHumidity: UIView!
    @IBOutlet weak var containerViewPressure: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windValueLabel: UILabel!
    @IBOutlet weak var feelsLikeValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!
    @IBOutlet weak var nextSevenDaysLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var hoursWeatherCollectionView: UICollectionView!
    
    weak var coordinator: Coordinator?
    let locationManager = CLLocationManager()
    let viewControllerManager = ViewControllerManager.shared
    var viewModel = ViewControllerViewModel()
    var disposeBag = DisposeBag()
    var delegate: ViewControllerDelegate?
    let date = Date()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.bind()
        self.bindCollection()
        self.addBorders()
        self.containerViewMainWeather.layer.cornerRadius = 30
        self.feelsLikeLabel.text = "Feels Like".localized
        self.humidityLabel.text = "Humidity".localized
        self.pressureLabel.text = "Pressure".localized
        self.windLabel.text = "Wind".localized
        self.nextSevenDaysLabel.text = "Next 7 Days".localized
        self.todayLabel.text = "Today".localized
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.loadWeather()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    func addBorders() {
        containerViewWind.addBorderTop(size: 1, color: .white)
        containerViewFeelsLike.addBorderLeft(size: 1, color: .white)
        containerViewFeelsLike.addBorderTop(size: 1, color: .white)
        containerViewPressure.addBorderLeft(size: 1, color: .white)
        containerViewHumidity.addBorderTop(size: 1, color: .white)
        containerViewPressure.addBorderTop(size: 1, color: .white)
    }
    
    func loadWeather() {
        self.viewModel.fetch()
    }
    
    func bind() {
        viewModel.currentDataSource.bind { [weak self] current in
            let todayDateFormatted = self?.date.getFormattedDate(format: "EEEE, d MMM")
            self?.dateLabel.text = todayDateFormatted
            self?.cityNameLabel.text = current?.name
            self?.temperatureLabel.text = "\(current?.main?.temp?.toString() ?? "error")°"
            self?.feelsLikeValueLabel.text = current?.main?.feels_like?.toString()
            self?.pressureValueLabel.text = "\(current?.main?.pressure ?? 0)"
            self?.humidityValueLabel.text = "\(current?.main?.humidity ?? 0)"
            self?.windValueLabel.text = current?.wind?.speed?.toString()
            self?.weatherConditionLabel.text = current?.weather?.first?.description
            if let url = URL(string: "https://openweathermap.org/img/wn/\(current?.weather?.first?.icon ?? "error")@2x.png") {
                self?.weatherConditionImage.sd_setImage(with: url)
            }
        }.disposed(by: disposeBag)
        
    }
    
    func bindCollection() {
        self.delegate = HoursCollectionViewCell()
        self.delegate?.bindCollectionData(with: hoursWeatherCollectionView)
    }
    
  
    
    @IBAction func geoButtonTapped(_ sender: UIButton) {
        self.viewControllerManager.factGeoWeather.accept(true)
        self.loadWeather()
    }
    
    @IBAction func sevenDaysButtonTapped(_ sender: UIButton) {
        coordinator?.eventHappended(with: .goToVC2)
    }
    
    @IBAction func FavoriteListButtonTapped(_ sender: UIButton) {
        coordinator?.eventHappended(with: .goToVC3)
    }
    
    
}


