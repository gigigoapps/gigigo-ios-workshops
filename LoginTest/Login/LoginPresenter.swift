//
//  LoginPresenter.swift
//  LoginTest
//
//  Created by Alejandro Jiménez on 30/9/21.
//

import Foundation

let kLocaleEmptyError = "Este campo no puede estar vacío"
let kLocaleLoginError = "Estas credenciales no son válidas"

protocol LoginUI: AnyObject {
    func showUserError(_ message: String)
    func showPasswordError(_ message: String)
    func showAlert(message: String)
}

protocol LoginPresenterProtocol {
    func onViewDidLoad()
    func userDidTapLoginButton(user: String?, password: String?)
}

struct LoginPresenter: LoginPresenterProtocol {
    
    // MARK: Public properties
    
    weak var view: LoginUI?
    let loginWireframe: LoginWireframeProtocol
    let interactor: LoginInteractor
    
    // MARK: - Public Methods
    
    func onViewDidLoad() {
        guard let userSession = self.interactor.getSession(), userSession.isLogged else { return }
        self.loginWireframe.navigateToHome(with: userSession.user)
    }
    
    func userDidTapLoginButton(user: String?, password: String?) {
        var isOK = self.check(user: user)
        isOK = self.check(password: password) && isOK
        
        guard isOK, let user = user, let password = password else { return }
        self.interactor.postLogin(user: user, password: password) { result in
            switch result {
            case .failure:
                self.view?.showAlert(message: kLocaleLoginError)
            case .success(let user):
                self.loginWireframe.navigateToHome(with: user)
            }
        }
    }
    
    // MARK: - Private Helper
    
    private func check(user: String?) -> Bool {
        guard let user = user, !user.isEmpty else {
            self.view?.showUserError(kLocaleEmptyError)
            return false
        }
        return true
    }
    
    private func check(password: String?) -> Bool {
        guard let password = password, !password.isEmpty else {
            self.view?.showPasswordError(kLocaleEmptyError)
            return false
        }
        return true
    }
    
}
