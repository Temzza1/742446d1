//
//  FavoriteListViewController.swift
//  WeatherApp
//
//  Created by Artem Mazur on 5/22/22.
//

import UIKit
import RxSwift
import RxCocoa

protocol FavoriteListControllerDelegate: AnyObject {
    func configureTable(with table: UITableView, textField: UITextField,  completion: @escaping () -> ())
}

class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var searchCityTextField: UITextField!
    @IBOutlet weak var favoriteCiryTableView: UITableView!
    
    var viewModel = FavoriteListViewModel()
    let viewControllerManager = ViewControllerManager.shared
    var delegate: FavoriteListControllerDelegate?
    weak var coordinator: Coordinator?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.viewModel.getCityList()
        self.setupTable()
        self.viewModel.fetchSearchCity(with: searchCityTextField) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.coordinator?.eventHappended(with: .goToVC1FromRight)
                self.viewModel.fetchCurrentListForecast()
            }
        }
    }
    
    
    func setupTable() {
        self.delegate = FavoriteListTableViewCell()
        delegate?.configureTable(with: favoriteCiryTableView, textField: searchCityTextField, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.coordinator?.eventHappended(with: .goToVC1FromRight)
                self.viewModel.fetchCurrentListForecast()
            }
        })
        self.view.backgroundColor = .white
        self.favoriteCiryTableView.backgroundColor = .white
        self.searchCityTextField.borderStyle = .bezel
        self.searchCityTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.searchCityTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.searchCityTextField.backgroundColor = .white
        self.searchCityTextField.attributedPlaceholder = NSAttributedString(
            string: "Type City Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        coordinator?.eventHappended(with: .goToVC1FromRight)
    }
    
    
}
