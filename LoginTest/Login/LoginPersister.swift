//
//  LoginPersister.swift
//  LoginTest
//
//  Created by Alejandro Jiménez on 14/10/21.
//

import Foundation

protocol UserDefaultsProtocol {
    func object(forKey defaultName: String) -> Any?
}
extension UserDefaults: UserDefaultsProtocol {}

struct LoginPersister: LoginPersisterProtocol {
    
    let userDefault: UserDefaultsProtocol
    
    func getSession() -> UserSession? {
        self.userDefault.object(forKey: "SESSION") as? UserSession
    }
    
}
