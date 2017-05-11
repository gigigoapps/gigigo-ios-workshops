//
//  LoginPresenter.swift
//  CleanArchitecture
//
//  Created by Judith Medina on 29/3/17.
//  Copyright © 2017 Judith Medina. All rights reserved.
//

import Foundation
import GIGLibrary

protocol LoginUI: class {
    func showAlert(message: String)
}

protocol LoginPresenterInput {
    func viewDidLoad()
    func userDidTapSignIn(username: String?, password: String?)
}

struct LoginPresenter {
    
    // MARK: - Public attributes
    
    weak var view: LoginUI?
    let wireframe: LoginWireframe
    
    // MARK: - Interactors
    
    var interactor: LoginInteractorInput
    
    func handle(error: Error) {
        
        switch error {
        case LoginError.credentialsNil, LoginError.credentialsEmpty:
            self.view?.showAlert(message: "Before proceeding add your username and password")

        case LoginError.invalidCredentials:
            self.view?.showAlert(message: "Username or password are invalid. Please try again.")
        default:
            break
        }
    }
}

// MARK: - LoginPresenterInput

extension LoginPresenter: LoginPresenterInput {
    
    func viewDidLoad() {
 
    }
    
    func userDidTapSignIn(username: String?, password: String?) {
        self.interactor.signIn(username: username, password: password)
    }

}

extension LoginPresenter: LoginInteractorOutput {
    
    func signInDidFinish(result: Result<User, Error>) {
        switch result {
        case .success(let user):
            self.view?.showAlert(message: user.username)
        case .error(let error):
            self.handle(error: error)
        }
    }
}
