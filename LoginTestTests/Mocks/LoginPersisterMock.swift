//
//  LoginPersisterMock.swift
//  LoginTestTests
//
//  Created by Alejandro Jiménez on 14/10/21.
//

import Foundation
@testable import LoginTest

class UserDefaultsMock: UserDefaultsProtocol {
    
    var fakeUserSession: UserSession?
    
    func object(forKey defaultName: String) -> Any? {
        self.fakeUserSession
    }

}
