//
//  TestsBuilder.swift
//  LoginTestTests
//
//  Created by Alejandro Jiménez on 7/10/21.
//

import Foundation
@testable import LoginTest

struct TestsBuilder {
    
    static func loginPresenter(view: LoginViewMock, wireframe: LoginWireframeMock, userDefaults: UserDefaultsMock) -> LoginPresenterProtocol {
        LoginPresenter(
            view: view,
            loginWireframe: wireframe,
            interactor: LoginInteractor(
                dataInput: LoginService(),
                persister: LoginPersister(
                    userDefault: userDefaults
                )
            )
        )
    }
    
}
