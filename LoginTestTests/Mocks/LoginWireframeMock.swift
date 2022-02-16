//
//  LoginWireframeMock.swift
//  LoginTestTests
//
//  Created by Alejandro Jiménez on 7/10/21.
//

import Foundation
@testable import LoginTest

class LoginWireframeMock: LoginWireframeProtocol {
    
    var spyNavigateToHomeWithUser: (called: Bool, user: User?) = (false, nil)
    
    func navigateToHome(with user: User) {
        self.spyNavigateToHomeWithUser = (true, user)
    }
    
}
