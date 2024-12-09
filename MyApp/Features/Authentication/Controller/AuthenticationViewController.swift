//
//  AuthenticationViewController.swift
//  MyApp
//
//  Created by Lorusso, Michele on 03/12/24.
//

import UIKit

protocol AuthenticationNavigation: AnyObject {
    func register()
    func login()
}

class AuthenticationViewController: UIViewController, Storyboarded {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    weak var coordinator: AuthenticationNavigation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Authentication".localized()
        
        registerButton.setTitle("Register".localized(), for: .normal)
        
        logInButton.setTitle("Log In".localized(), for: .normal)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        coordinator?.register()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        coordinator?.login()
    }
    
    
}
