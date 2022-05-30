//
//  AppCoordinator.swift
//  WeatherApp
//
//  Created by Artem Mazur on 4/12/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func eventHappended(with type: Event) {
        switch type {
        case .goToVC1FromLeft:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                ViewControllerManager.shared.factGeoWeather.accept(true)
            }
            openVC1(side: .fromLeft)
        case .goToVC1FromRight:
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                ViewControllerManager.shared.factGeoWeather.accept(false)
            }
            openVC1(side: .fromRight)
        case .goToVC2:
            openVC2()
        case .goToVC3:
            openVC3()
        case .openMainController:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                ViewControllerManager.shared.factGeoWeather.accept(true)
                self.openMainController()
            }
            
        }
        
    }
    
    func chooseSideForOpen(to vc: UIViewController, from: CATransitionSubtype) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.push
        transition.subtype = from
        navigationController.view.layer.add(transition, forKey: kCATransition)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func start() {
        let vc = StartViewController.createObject()
        vc.coordinator = self
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func openVC1(side: CATransitionSubtype) {
        let vc1 = ViewController.createObject()
        vc1.coordinator = self
        
        chooseSideForOpen(to: vc1, from: side)
        
    }
    
    func openVC2() {
        let vc2 = SecondViewController.createObject()
        vc2.coordinator = self
        navigationController.pushViewController(vc2, animated: true)
    }
    
    func openVC3() {
        let vc3 = FavoriteListViewController.createObject()
        vc3.coordinator = self
        chooseSideForOpen(to: vc3, from: .fromLeft)
    }
    
    func openMainController() {
        let mainVC = ViewController.createObject()
        mainVC.coordinator = self
        chooseSideForOpen(to: mainVC, from: .fromTop)
    }
    
    
    
    
}
