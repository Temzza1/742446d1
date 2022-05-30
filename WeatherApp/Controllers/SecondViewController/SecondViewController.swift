//
//  SecondViewController.swift
//  WeatherApp
//
//  Created by Artem Mazur on 23.02.2022.
//

import UIKit
import RxCocoa
import RxSwift

protocol SecondViewControllerDelegate: AnyObject {
    func configureTable(with table: UITableView)
}

class SecondViewController: UIViewController {

    
    @IBOutlet weak var cityNameTitle: UILabel!
    @IBOutlet weak var dailyWeatherTableView: UITableView!
    @IBOutlet weak var nextDaysLabel: UILabel!
    var delegate: SecondViewControllerDelegate?
    let viewControllerManager = ViewControllerManager.shared
    var viewModel = SecondViewModel()
    weak var coordinator: Coordinator?
    var disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.setupTable()
        self.setCityNameTitle()
        
    }
    
    func setupTable() {
        self.delegate = DailyTableViewCell()
        delegate?.configureTable(with: dailyWeatherTableView)
        self.viewModel.fetchDailyForecast()
    }
    
    func setCityNameTitle() {
        cityNameTitle.text = self.viewControllerManager.currentWeather.value?.name
        
        let nextDaysTitle = "Next 7 Days".localized
        
        nextDaysLabel.text = nextDaysTitle
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        coordinator?.eventHappended(with: .goToVC1FromLeft)
    }
}

