//
//  Storyboarded.swift
//  Coordinators
//
//  Created by Lorusso, Michele on 06/12/24.
//

import UIKit

protocol Storyboarded{
    static func instantiate(storyboardName: String) -> Self
}


extension Storyboarded where Self: UIViewController {
    static func instantiate(storyboardName: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
