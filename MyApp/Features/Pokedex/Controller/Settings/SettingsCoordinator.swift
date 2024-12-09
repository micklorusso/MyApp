//
//  ProfileCoordinator.swift
//  MyApp
//
//  Created by Lorusso, Michele on 06/12/24.
//

import UIKit

class SettingsCoordinator: Coordinator {
    weak var parentCoordinator: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        let vc = SettingsViewController.instantiate(storyboardName: "Settings")
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: TabBarItems.settings.rawValue)
        navigationController.viewControllers = [vc]
    }
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
}
