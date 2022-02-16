//
//  File.swift
//  LoginTest
//
//  Created by Alejandro Jiménez on 7/10/21.
//

import Foundation
import Alamofire

struct User: Codable {
    let id: String
    let name: String
}

extension User: Equatable {}

struct LoginService: LoginInteractorInput {
    
    func postLogin(user: String, password: String, completion: @escaping (Result<User, AFError>) -> Void) {
        AF.request("https://test_host/login").responseDecodable(of: User.self) { response in
            completion(response.result)
        }
    }
    
}

