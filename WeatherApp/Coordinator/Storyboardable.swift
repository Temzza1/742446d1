//
//  Storyboardable.swift
//  WeatherApp
//
//  Created by Artem Mazur on 4/12/22.
//

import UIKit

protocol Storyboardable {
    static func createObject() -> Self
}

extension Storyboardable where Self: UIViewController {
    static func createObject() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
