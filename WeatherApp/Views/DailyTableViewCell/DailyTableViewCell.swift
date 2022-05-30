//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Artem Mazur on 09.03.2022.
//

import UIKit
import RxCocoa
import RxSwift

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var tempTitle: UILabel!
    let viewModel = DailyCellModel()
    var disposeBag = DisposeBag()
    
    static let id = "DailyTableViewCell"
    
    func configure(with model: DailyInfo) {
        let dateResult = model.dt
        let date = Date(timeIntervalSince1970: TimeInterval(dateResult))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        let localDate = dateFormatter.string(from: date)
        
        self.dateTitle.text = localDate.localized
        self.tempTitle.text = "\(model.temp.max.toString()) / \(model.temp.min.toString())"
        let url = URL(string: "https://openweathermap.org/img/wn/\(model.weather.first?.icon ?? "error")@2x.png")
        self.weatherIcon.sd_setImage(with: url)
        
    }
    
    func bindTable(with tableView: UITableView) {
        viewModel.dailyDataSource
            .bind(to: tableView
                .rx
                .items(cellIdentifier: DailyTableViewCell.id, cellType: DailyTableViewCell.self)) {index, model, cell in
                    cell.configure(with: model)
                }.disposed(by: disposeBag)
    }
}

extension DailyTableViewCell: SecondViewControllerDelegate {
    func configureTable(with table: UITableView) {
        self.bindTable(with: table)
    }
}
