//
//  ViewControllerAuthExtension.swift
//  MyApp
//
//  Created by Lorusso, Michele on 03/12/24.
//

import FirebaseAuth
import UIKit

extension UIViewController {
    func getNavBarAuthenticaionAction() {
        if Auth.auth().currentUser != nil {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Log Out", style: .plain, target: self,
                action: #selector(logOutAction))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Log In", style: .plain, target: self,
                action: #selector(logInAction))
        }
    }

    @objc func logOutAction() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

    @objc func logInAction() {
        print("Bar button item tapped")
    }
}
