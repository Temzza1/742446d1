//
//  FavoriteListTableViewModel.swift
//  WeatherApp
//
//  Created by Artem Mazur on 5/23/22.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteListTableViewModel {
    
    let viewControllerManager = ViewControllerManager.shared
    var cityList = ViewControllerManager.shared.cityList
    weak var coordinator: Coordinator?
    var disposeBag = DisposeBag()
    
    func bindTable(with tableView: UITableView, textField: UITextField) {
        textField.rx.text.orEmpty
            .debounce(.microseconds(50), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map { word in
                self.cityList.value.filter { city in
                    city.name.lowercased().contains(word.lowercased())
                }
            }
            .bind(to: tableView
                .rx
                .items(cellIdentifier: FavoriteListTableViewCell.id, cellType: FavoriteListTableViewCell.self)) {index, model, cell in
                    cell.configure(with: model)
                }.disposed(by: disposeBag)
        
    }
    
    func selectedRow(with tableView: UITableView,  completion: @escaping () -> ()) {
        tableView.rx.modelSelected(City.self)
            .subscribe { [weak self] city in
                if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                    tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
                self?.viewControllerManager.cityName.accept(city.element?.name ?? "")
                self?.viewControllerManager.factGeoWeather.accept(false)
                completion()
            }.disposed(by: disposeBag)
        
        
    }
}
