//
//  ViewControllerCoordinator.swift
//  WeatherApp
//
//  Created by Artem Mazur on 4/7/22.
//

import UIKit

class ViewControllerCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        
        let viewModel = ViewControllerViewModel()
        viewModel.delegate = self
        controller.viewModel = viewModel
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
    }
    
    private func openWeekForecast() {
        let coordinator = SecondViewControllerCoordinator(window: window)
        coordinator.start()
    }
    
    
}

extension ViewControllerCoordinator: ViewControllerModelDelegate {
    
    func presentWeekForecast() {
        openWeekForecast()
    }
}
