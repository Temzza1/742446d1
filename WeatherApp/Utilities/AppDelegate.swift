//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Artem Mazur on 16.02.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var coordinator: AppCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navVC = UINavigationController()
        navVC.navigationBar.isHidden = true
        coordinator = AppCoordinator(navigationController: navVC)
        coordinator?.start()
    
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
        self.window = window
       
        FirebaseApp.configure()
        
        return true
    }
    

}

