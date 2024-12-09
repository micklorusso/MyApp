//
//  Coordinator.swift
//  Coordinators
//
//  Created by Lorusso, Michele on 06/12/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}
