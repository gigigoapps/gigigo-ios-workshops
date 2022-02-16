//
//  LoginViewMock.swift
//  LoginTestTests
//
//  Created by Alejandro Jiménez on 30/9/21.
//

import Foundation
@testable import LoginTest

class LoginViewMock: LoginUI {
    
    // Spies
    var spyShowUserErrorMessage: String?
    var spyShowPasswordErrorMessage: String?
    var spyShowAlertMessage: String?
    
    func showUserError(_ message: String) {
        self.spyShowUserErrorMessage = message
    }
    
    func showPasswordError(_ message: String) {
        self.spyShowPasswordErrorMessage = message
    }
    
    func showAlert(message: String) {
        self.spyShowAlertMessage = message
    }
}
