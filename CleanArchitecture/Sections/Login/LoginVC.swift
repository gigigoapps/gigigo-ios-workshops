//
//  LoginVC.swift
//  CleanArchitecture
//
//  Created by Judith Medina on 29/3/17.
//  Copyright © 2017 Judith Medina. All rights reserved.
//

import UIKit
import GIGLibrary

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    // MARK: - Attributtes
    
    var presenter: LoginPresenterInput?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    // MARK: - Events

    @IBAction func signInTapped(_ sender: Any) {
        self.presenter?.userDidTapSignIn(
            username: self.emailTextField.text,
            password: self.passwordTextField.text)
    }
}

// MARK: - Instantiable

extension LoginVC: Instantiable {
    
    public static func storyboard() -> String {
        return "Login"
    }
    
    public static func identifier() -> String? {
        return "LoginVC"
    }
}

// MARK: - LoginUI

extension LoginVC: LoginUI {
    
    func showAlert(message: String) {
        let alert = Alert(title: "Clean", message: message)
        alert.addDefaultButton("OK", usingAction: nil)
        alert.show()
    }
}


