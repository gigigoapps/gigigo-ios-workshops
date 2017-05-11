//
//  LoginPresenter.swift
//  CleanArchitecture
//
//  Created by Judith Medina on 29/3/17.
//  Copyright © 2017 Judith Medina. All rights reserved.
//

import Foundation
import GIGLibrary

enum LoginError: Error {
    case credentialsNil
    case credentialsEmpty
    case invalidCredentials
}

protocol LoginInteractorInput {
    func signIn(username: String?, password: String?)
}

protocol LoginInteractorOutput {
    func signInDidFinish(result: Result<User, Error>)
}

class LoginInteractor {
    
    // MARK: - Interactor output
    
    var service: LoginService
    var output: LoginInteractorOutput?
    
    init(service: LoginService) {
        self.service = service
    }
}

extension LoginInteractor: LoginInteractorInput {
  
    func signIn(username: String?, password: String?) {
        guard
            let email = username,
            let password = password
            else {
                self.output?.signInDidFinish(
                    result: Result.error(LoginError.credentialsNil))
                return LogWarn("Email or password is empty") }
        
        if email.isEmpty || password.isEmpty {
            self.output?.signInDidFinish(
                result:Result.error(LoginError.credentialsEmpty))
            return
        }
        
        let success = self.service.signIn(username: email, password: password)
        if success {
            let user = User(username: email)
            self.output?.signInDidFinish(
                result: Result.success(user))
        } else {
            self.output?.signInDidFinish(
                result: Result.error(LoginError.invalidCredentials))
        }
        
    }
}
