//
//  AppController.swift
//  CleanArchitecture
//
//  Created by Judith Medina on 29/3/17.
//  Copyright © 2017 Judith Medina. All rights reserved.
//

import UIKit

class AppController {
    
    static let shared = AppController()
    var appWireframe: AppWireframe?
    
    func appDidLaunch() {
        self.appWireframe?.showAppLaunchWireframe()
    }
    
}
