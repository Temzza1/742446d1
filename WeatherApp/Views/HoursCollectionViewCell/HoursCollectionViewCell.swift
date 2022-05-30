//
//  HoursCollectionViewCell.swift
//  WeatherApp
//
//  Created by Artem Mazur on 14.03.2022.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift

class HoursCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var tempConditionImage: UIImageView!
    @IBOutlet weak var tempValue: UILabel!
    let viewModel = HoursCellModel()
    var disposeBag = DisposeBag()
    
    static let id = "HoursCollectionViewCell"
    
    
    func configure(with model: Hourly) {
        let dateResult = model.dt
        let date = Date(timeIntervalSince1970: TimeInterval(dateResult))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = .current
        dateFormatter.timeZone = TimeZone(identifier: self.viewModel.viewControllerManager.hourly.value?.timezone ?? "")
        let localDate = dateFormatter.string(from: date)
        tempValue.text = model.temp.toString()
        hourLabel.text = localDate
        if let url = URL(string: "https://openweathermap.org/img/wn/\(model.weather.first?.icon ?? "error")@2x.png") {
            self.tempConditionImage.sd_setImage(with: url)
        }
        self.backgroundColor = #colorLiteral(red: 0, green: 0.5882352941, blue: 1, alpha: 1)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.1
        self.hourLabel.textColor = .white
        self.tempValue.textColor = .white
    }
    
    func bindCollection(with collection: UICollectionView) {
        viewModel.hourlyDataSource
            .bind(to: collection
                .rx
                .items(cellIdentifier: HoursCollectionViewCell.id, cellType: HoursCollectionViewCell.self)) {index, model, cell in
                    cell.configure(with: model)
                }.disposed(by: disposeBag)
    }
}

extension HoursCollectionViewCell: ViewControllerDelegate {
    func bindCollectionData(with collection: UICollectionView) {
        self.bindCollection(with: collection)
    }
}
