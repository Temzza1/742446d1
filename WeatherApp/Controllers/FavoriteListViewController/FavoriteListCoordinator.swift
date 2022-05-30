//
//  FavoriteListCoordinator.swift
//  WeatherApp
//
//  Created by Artem Mazur on 5/22/22.
//

import UIKit

class FavoriteListCoordinator {
    
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoriteListViewController") as? FavoriteListViewController else { return }
        
        let viewModel = FavoriteListViewModel()
        viewModel.delegate = self
        controller.viewModel = viewModel
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
    }

    private func showFavoriteList() {
        let coordinator = FavoriteListCoordinator(window: window)
        coordinator.start()
    }
    
}

extension FavoriteListCoordinator: FavoriteListViewModelDelegate {
    func openFavoriteList() {
        showFavoriteList()
    }
    
    
}


