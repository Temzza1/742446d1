//
//  FavoriteListTableViewCell.swift
//  WeatherApp
//
//  Created by Artem Mazur on 5/22/22.
//

import UIKit
import RxCocoa
import RxSwift

class FavoriteListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    let viewModel = FavoriteListTableViewModel()
    weak var coordinator: Coordinator?
    var disposeBag = DisposeBag()
    
    static let id = "FavoriteListTableViewCell"
    
    func configure(with model: City) {
        self.backgroundColor = .white
        self.cityNameLabel.textColor = .black
        self.tempLabel.textColor = .black
        self.cityNameLabel.text = model.name
        self.tempLabel.text = model.country
    }
    
}

extension FavoriteListTableViewCell: FavoriteListControllerDelegate {
    func configureTable(with table: UITableView, textField: UITextField, completion: @escaping () -> ()) {
        
        self.viewModel.bindTable(with: table, textField: textField)
        self.viewModel.selectedRow(with: table) {
            completion()
        }
    }

}
