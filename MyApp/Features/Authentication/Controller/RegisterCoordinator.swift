//
//  RegisterCoordinator.swift
//  MyApp
//
//  Created by Lorusso, Michele on 09/12/24.
//

import UIKit


class RegisterCoordinator: Coordinator {
    

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var parentCoordinator: AuthenticationCoordinaotor?

    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }

    func start() {
        let vc = RegisterViewController.instantiate(
            storyboardName: "Register")
        vc.didRegister = { [weak self] in self?.didFinish()}
        navigationController.pushViewController(vc, animated: true)
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}
