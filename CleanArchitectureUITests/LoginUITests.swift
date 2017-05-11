//
//  LoginUITests.swift
//  CleanArchitecture
//
//  Created by Judith Medina on 5/4/17.
//  Copyright © 2017 Judith Medina. All rights reserved.
//

import XCTest
import Nimble

class LoginUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
    
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_empty_username_and_password() {
        let alert = self.app.alerts["Clean"]
        let exists = NSPredicate(format: "exists == 1")
        
        self.app.buttons["loginButton"].tap()

        self.expectation(for: exists, evaluatedWith: alert, handler: nil)
        self.waitForExpectations(timeout: 2.0) { Error in
            alert.buttons["OK"].tap()
        }
    }
    
    func test_username_and_password_fields_are_visible_in_screen() {
        XCTAssertTrue(self.app.textFields["emailTextField"].isHittable)
        XCTAssertTrue(self.app.secureTextFields["passwordTextField"].isHittable)
    }
    
    func test_username_and_password_fields_are_enables_in_screen() {
        XCTAssertTrue(self.app.textFields["emailTextField"].isEnabled)
        XCTAssertTrue(self.app.secureTextFields["passwordTextField"].isEnabled)
    }
    
}
