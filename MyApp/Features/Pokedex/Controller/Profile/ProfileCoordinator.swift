//
//  ProfileCoordinator.swift
//  MyApp
//
//  Created by Lorusso, Michele on 06/12/24.
//

import UIKit

class ProfileCoordinator: Coordinator {
    weak var parentCoordinator: TabBarCoordinator?
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        let vc = ProfileViewController.instantiate(storyboardName: "Profile")
        vc.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill"), tag: TabBarItems.profile.rawValue)
        navigationController.viewControllers = [vc]
    }
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
}
