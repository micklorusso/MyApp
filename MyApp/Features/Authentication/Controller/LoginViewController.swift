//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import UIKit

class LoginViewController: UIViewController, Storyboarded {
    var didLogin: (() -> Void)?
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    @IBOutlet weak var popupLabel: UILabel!

    override func viewDidLoad() {
        popupLabel.layer.cornerRadius = 24
        popupLabel.isHidden = true
            
        logInButton.setTitle("Log In".localized(), for: .normal)
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text,
            let password = passwordTextfield.text
        {
            Auth.auth().signIn(withEmail: email, password: password) {
                authResult, error in
                DispatchQueue.main.async {
                    if let e = error {
                        self.popupLabel.text = e.localizedDescription
                        self.popupLabel.isHidden = false
                        Timer.scheduledTimer(
                            withTimeInterval: 2, repeats: false
                        ) {
                            (timer) in self.popupLabel.isHidden = true
                        }
                        print(e.localizedDescription)
                    } else {
                        self.didLogin?()
                    }
                }
            }
        }
    }

}
