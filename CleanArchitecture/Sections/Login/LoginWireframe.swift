//
//  LoginRouter.swift
//  CleanArchitecture
//
//  Created by Judith Medina on 29/3/17.
//  Copyright © 2017 Judith Medina. All rights reserved.
//

import Foundation
import GIGLibrary

struct LoginWireframe {
    
    var navigationController: UINavigationController
    
    /// Method to show the Login section
    ///
    /// - Returns: Login View Controller with all dependencies
    func showLogin() -> LoginVC? {
        guard let viewController = try? Instantiator<LoginVC>().viewController() else { return nil }
        let wireframe = self
        
        let interactor =  LoginInteractor(service: LoginService())
        
        let presenter = LoginPresenter(
            view: viewController,
            wireframe: wireframe,
            interactor: interactor)
        viewController.presenter = presenter
        interactor.output = presenter
        
        return viewController
    }

}
