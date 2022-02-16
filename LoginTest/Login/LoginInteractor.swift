//
//  LoginInteractor.swift
//  LoginTest
//
//  Created by Alejandro Jiménez on 30/9/21.
//

import Foundation
import Alamofire

struct UserSession {
    let user: User
    let isLogged: Bool
}

protocol LoginInteractorInput {
    func postLogin(user: String, password: String, completion: @escaping (Result<User, AFError>) -> Void)
}

protocol LoginPersisterProtocol {
    func getSession() -> UserSession?
}

struct LoginInteractor {
    
    let dataInput: LoginInteractorInput
    let persister: LoginPersisterProtocol
    
    func getSession() -> UserSession? {
        self.persister.getSession()
    }
    
    func postLogin(user: String, password: String, completion: @escaping (Result<User, AFError>) -> Void) {
        self.dataInput.postLogin(user: user, password: password, completion: completion)
    }
    
}
