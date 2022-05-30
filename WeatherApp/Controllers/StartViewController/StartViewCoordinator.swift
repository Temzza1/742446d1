//
//  StartViewCoordinator.swift
//  WeatherApp
//
//  Created by Artem Mazur on 5/30/22.
//

import UIKit

class StartViewCoordinator {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartViewController") as? StartViewController else { return }
        
        let viewModel = StartViewModel()
        //    viewModel.delegate = self
        controller.viewModel = viewModel
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
    }
    
    
}
