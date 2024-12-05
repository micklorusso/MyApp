//
//  AuthenticationViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 03/12/24.
//

import UIKit

class AuthenticationViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Authentication".localized()
        
        registerButton.setTitle("Register".localized(), for: .normal)
        
        logInButton.setTitle("Log In".localized(), for: .normal)
    }
    

}
