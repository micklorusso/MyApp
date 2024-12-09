//
//  AuthenticationCoordinaotr.swift
//  MyApp
//
//  Created by Lorusso, Michele on 09/12/24.
//

import UIKit

class AuthenticationCoordinaotor: NSObject, Coordinator, AuthenticationNavigation {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: TabBarCoordinator?

    func start() {
        let vc = AuthenticationViewController.instantiate(
            storyboardName: "Authentication")
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func register() {
        let child = RegisterCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func login() {
        let child = LoginCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    func childDidFinish(_ child: Coordinator?){
        //print(childCoordinators)
        for (index, coordinator) in
                childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        //print(childCoordinators)
        parentCoordinator?.childDidFinish(self)
    }
}
