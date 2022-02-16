//
//  UserFakes.swift
//  LoginTestTests
//
//  Created by Alejandro Jiménez on 7/10/21.
//

import Foundation
@testable import LoginTest

struct UserFakes {
    
    /// Reflects success.json
    static let user1: User = {
        User(id: "ID_TEST", name: "USER_NAME")
    }()
}
