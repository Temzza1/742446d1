//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Artem Mazur on 4/12/22.
//

import UIKit

enum Event {
    case goToVC1FromLeft
    case goToVC1FromRight
    case goToVC2
    case goToVC3
    case openMainController
}

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    
    func eventHappended(with type: Event)
    func start()
}
