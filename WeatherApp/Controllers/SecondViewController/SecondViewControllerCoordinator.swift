//
//  SecondViewControllerCoordinator.swift
//  WeatherApp
//
//  Created by Artem Mazur on 4/7/22.
//

import UIKit

class SecondViewControllerCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        let viewModel = SecondViewModel()
        viewModel.delegate = self
        controller.viewModel = viewModel
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
        
    }
    
    func openViewController() {
        
        let coordinator = ViewControllerCoordinator(window: window)
        coordinator.start()
        
    }
    
}

extension SecondViewControllerCoordinator: SecondViewModelDelegate {
    func buttonPressed() {
        openViewController()
    }
}

