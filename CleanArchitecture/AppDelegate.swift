//
//  AppDelegate.swift
//  CleanArchitecture
//
//  Created by Judith Medina on 29/3/17.
//  Copyright © 2017 Judith Medina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appController = AppController.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        prepareAppController()
        appController.appDidLaunch()
        
        return true
    }
    
    // MARK: - Private Helpers
    
    fileprivate func prepareAppController() {
        appController.appWireframe = AppWireframe()
        appController.appWireframe?.window = self.window
    }
}

