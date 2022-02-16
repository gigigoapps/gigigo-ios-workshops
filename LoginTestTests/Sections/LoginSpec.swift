//
//  LoginSpec.swift
//  LoginTestTests
//
//  Created by Alejandro Jiménez on 30/9/21.
//

import Quick
import Nimble
@testable import LoginTest

class LoginSpec: QuickSpec {
    
    var presenter: LoginPresenterProtocol!
    var viewMock: LoginViewMock!
    var wireframeMock: LoginWireframeMock!
    var userDefaultsMock: UserDefaultsMock!
    
    override func spec() {
        describe("login") {
            beforeEach {
                self.viewMock = LoginViewMock()
                self.wireframeMock = LoginWireframeMock()
                self.userDefaultsMock = UserDefaultsMock()
                self.presenter = TestsBuilder.loginPresenter(
                    view: self.viewMock,
                    wireframe: self.wireframeMock,
                    userDefaults: self.userDefaultsMock
                )
            }
            afterEach {
                self.presenter = nil
                self.viewMock = nil
                self.wireframeMock = nil
                self.userDefaultsMock = nil
            }
            context("when user is empty") {
                beforeEach {
                    self.presenter.userDidTapLoginButton(user: "", password: "TEST")
                }
                it("must show empty error") {
                    expect(self.viewMock.spyShowUserErrorMessage).to(equal(kLocaleEmptyError))
                }
            }
            context("when password is empty") {
                beforeEach {
                    self.presenter.userDidTapLoginButton(user: nil, password: nil)
                }
                it("must show empty error") {
                    expect(self.viewMock.spyShowPasswordErrorMessage).to(equal(kLocaleEmptyError))
                }
            }
            context("when user not exist") {
                beforeEach {
                    StubResponse.mockFailureResponse(for: "/login", with: "failure.json")
                    self.presenter.userDidTapLoginButton(user: "USER_TEST", password: "PASSWORD_TEST")
                }
                it("should show alert with error message") {
                    expect(self.viewMock.spyShowAlertMessage).toEventually(equal(kLocaleLoginError))
                }
            }
            context("when login success") {
                beforeEach {
                    StubResponse.mockSuccessResponse(for: "/login", with: "success.json")
                    self.presenter.userDidTapLoginButton(user: "USER_TEST", password: "PASSWORD_TEST")
                }
                it("should navigate to home") {
                    expect(self.wireframeMock.spyNavigateToHomeWithUser.user).toEventually(equal(UserFakes.user1))
                }
            }
            context("when user has session") {
                beforeEach {
                    self.userDefaultsMock.fakeUserSession = UserSession(user: User(id: "ID_TEST", name: "USER_NAME"), isLogged: true)
                    self.presenter.onViewDidLoad()
                }
                it("should navigate to home") {
                    expect(self.wireframeMock.spyNavigateToHomeWithUser.called).toEventually(beTrue())
                    expect(self.wireframeMock.spyNavigateToHomeWithUser.user).toEventually(equal(UserFakes.user1))
                }
            }
            context("when user has no session") {
                beforeEach {
                    self.userDefaultsMock.fakeUserSession = UserSession(user: User(id: "ID_TEST", name: "USER_NAME"), isLogged: false)
                    self.presenter.onViewDidLoad()
                }
                it("should navigate to home") {
                    expect(self.wireframeMock.spyNavigateToHomeWithUser.called).toNotEventually(beTrue())
                }
            }
        }
    }
    
}
