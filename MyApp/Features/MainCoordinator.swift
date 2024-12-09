//
//  MainCoordinator.swift
//  Coordinators
//
//  Created by Lorusso, Michele on 06/12/24.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    func start() {
        let vc = SplashScreenViewController.instantiate(storyboardName: "Main")
        vc.transitionToMainScreen = { [weak self] in self?.transitionToMainScreen()}
        navigationController.pushViewController(vc, animated: false)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func transitionToMainScreen(){
        let child = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
    
}
