//
//  ContactUtilityUITests.swift
//  ContactUtilityUITests
//
//  Created by Hitesh on 28/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import XCTest

class ContactUtilityUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        XCUIDevice.sharedDevice().orientation = .Portrait
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["John Appleseed"].tap()
        tablesQuery.staticTexts["Kate Bell"].tap()
        tablesQuery.searchFields["Search"].tap()
        app.searchFields["Search"].typeText("A")
        app.tables["Search results"].staticTexts["Anna Haro"].tap()
        app.buttons["Cancel"].tap()
    }
    
    func testSearchBar(){
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        app.tables.searchFields["Search"].tap()
        app.searchFields["Search"].typeText("Hank")
        
        app.tables["Search results"].tap()
        app.tables["Search results"].staticTexts["Hank Zakroff"].tap()
        app.buttons["Cancel"].tap()
    }
    
}
