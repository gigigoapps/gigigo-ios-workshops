//
//  AppWireframe.swift
//  CleanArchitecture
//
//  Created by Judith Medina on 29/3/17.
//  Copyright © 2017 Judith Medina. All rights reserved.
//

import UIKit
import GIGLibrary

class AppWireframe {
    
    var window: UIWindow?
    
    private var navigationController = UINavigationController()

    func showAppLaunchWireframe() {
        let loginWireframe = LoginWireframe(navigationController: self.navigationController)
    
        guard let loginVC = loginWireframe.showLogin() else {
            LogWarn("loginVC not found")
            return
        }
        
        self.navigationController.setViewControllers([loginVC], animated: false)
        window?.rootViewController = self.navigationController
    }

    
    // MARK: UIViewController
    
    func dissmiss(completion: (() -> Void)? = nil) {
        self.topViewController()?.dismiss(animated: true, completion: completion)
    }
    
    // MARK: - Private Helpers
    
    private func topViewController() -> UIViewController? {
        var rootVC = UIApplication.shared.keyWindow?.rootViewController
        
        while let presentedController = rootVC?.presentedViewController {
            rootVC = presentedController
        }
        
        return rootVC
    }
}
