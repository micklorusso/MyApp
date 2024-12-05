//
//  MainTabBarController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 03/12/24.
//

import FirebaseAuth
import UIKit

enum TabBarItems: Int {
    case pokedex = 0
    case settings = 1
    case profile = 2
}

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self

        if let tabBarItems = tabBar.items {
            tabBarItems[TabBarItems.pokedex.rawValue].title = "Pokedex"
            tabBarItems[TabBarItems.settings.rawValue].title = "Settings"
                .localized()
            tabBarItems[TabBarItems.profile.rawValue].title = "Profile"
                .localized()
        }

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
            tabBar.items?[TabBarItems.profile.rawValue].isEnabled = true
        } else {
            tabBar.items?[TabBarItems.profile.rawValue].isEnabled = false

            if self.selectedIndex == TabBarItems.profile.rawValue {
                self.selectedIndex = TabBarItems.pokedex.rawValue
            }
        }
    }

    func updateNavigationBar(for user: User?) {
        guard
            let selectedNavController = self.selectedViewController
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
        let storyboard = UIStoryboard(
            name: Files.Storyboard.authenticationName, bundle: nil)
        let authVC = storyboard.instantiateViewController(
            withIdentifier: Files.Storyboard.authenticationID)
        let navController = UINavigationController(rootViewController: authVC)
        authVC.navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Back".localized(), style: .plain, target: self,
            action: #selector(dismissAuthVC)
        )
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }

    @objc func dismissAuthVC() {
        dismiss(animated: true, completion: nil)
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
    ) {
        updateNavigationBar(for: Auth.auth().currentUser)
    }
}
