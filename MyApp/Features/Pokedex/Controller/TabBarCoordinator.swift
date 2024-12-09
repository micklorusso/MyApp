//
//  TabBarCoordinator.swift
//  MyApp
//
//  Created by Lorusso, Michele on 06/12/24.
//

import UIKit
import FirebaseAuth

enum TabBarItems: Int {
    case pokedex = 0
    case settings = 1
    case profile = 2
}

class TabBarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    private let tabBarController: UITabBarController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    func start() {
        let pokedexCoordinator = PokedexCoordinator(navigationController: UINavigationController())
        let settingsCoordinator = SettingsCoordinator(navigationController: UINavigationController())
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())

        
        childCoordinators.append(pokedexCoordinator)
        childCoordinators.append(settingsCoordinator)
        childCoordinators.append(profileCoordinator)
        
        pokedexCoordinator.start()
        settingsCoordinator.start()
        profileCoordinator.start()

        tabBarController.viewControllers = [
            pokedexCoordinator.navigationController,
            settingsCoordinator.navigationController,
            profileCoordinator.navigationController,
        ]

        navigationController.viewControllers = [tabBarController]
        
        setupAuthStateListener()
        
    }
    
    func setupAuthStateListener() {
           _ = Auth.auth().addStateDidChangeListener { [weak self] _, user in
               guard let self = self else { return }
               self.updateTabBarItems(for: user)
               self.updateNavigationBar(for: user)
           }
       }
    
    func updateTabBarItems(for user: User?) {
            if user != nil {
                tabBarController.tabBar.items?[TabBarItems.profile.rawValue].isEnabled = true
            } else {
                tabBarController.tabBar.items?[TabBarItems.profile.rawValue].isEnabled = false

                if tabBarController.selectedIndex == TabBarItems.profile.rawValue {
                    tabBarController.selectedIndex = TabBarItems.pokedex.rawValue
                }
            }
        }

        func updateNavigationBar(for user: User?) {
            guard
                let selectedNavController = tabBarController.selectedViewController
                    as? UINavigationController,
                let visibleController = selectedNavController.viewControllers.last
            else {
                return
            }

            if user != nil {
                visibleController.navigationItem.rightBarButtonItem =
                    UIBarButtonItem(
                        title: "Log Out".localized(),
                        style: .plain,
                        target: self,
                        action: #selector(self.handleLogout)
                    )
            } else {
                visibleController.navigationItem.rightBarButtonItem =
                    UIBarButtonItem(
                        title: "Log In".localized(),
                        style: .plain,
                        target: self,
                        action: #selector(self.handleLogin)
                    )
            }
        }

        @objc func handleLogout() {
            do {
                try Auth.auth().signOut()
                print("User logged out")
            } catch let error {
                print("Failed to log out: \(error.localizedDescription)")
            }
        }

        @objc func handleLogin() {
            let child = AuthenticationCoordinaotor(navigationController: navigationController)
            child.parentCoordinator = self
            childCoordinators.append(child)
            child.start()
        }
    
    
    func childDidFinish(_ child: Coordinator?){
        print(childCoordinators)
        for (index, coordinator) in
                childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        print(childCoordinators)
        navigationController.popToRootViewController(animated: true)
    }
}
