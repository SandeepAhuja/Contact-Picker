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
        
        let settingsButton = app.navigationBars["Contacts"].buttons["Settings"]
        settingsButton.tap()
        
        let settingsNavigationBar = app.navigationBars["Settings"]
        settingsNavigationBar.buttons["Cancel"].tap()
        settingsButton.tap()
        
        let doneButton = settingsNavigationBar.buttons["Done"]
        doneButton.tap()
        settingsButton.tap()
        
        let tablesQuery = app.tables
        let searchbarSwitch = tablesQuery.switches["SearchBar"]
        searchbarSwitch.tap()
        searchbarSwitch.tap()
        
        let indexedSearchSwitch = tablesQuery.switches["Indexed Search"]
        indexedSearchSwitch.tap()
        indexedSearchSwitch.tap()
        searchbarSwitch.tap()
        indexedSearchSwitch.tap()
        doneButton.tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSearchbarOnOff(){
    
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        let settingsButton = app.navigationBars["Contacts"].buttons["Settings"]
        settingsButton.tap()
        
        let searchbarSwitch = app.tables.switches["SearchBar"]
        searchbarSwitch.tap()
        
        let settingsNavigationBar = app.navigationBars["Settings"]
        let doneButton = settingsNavigationBar.buttons["Done"]
        doneButton.tap()
        settingsButton.tap()
        searchbarSwitch.tap()
        doneButton.tap()
        settingsButton.tap()
        searchbarSwitch.tap()
        searchbarSwitch.tap()
        doneButton.tap()
        settingsButton.tap()
        settingsNavigationBar.buttons["Cancel"].tap()
        
    }
    
    func testIndexedSearchOnOff(){
   
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        let settingsButton = app.navigationBars["Contacts"].buttons["Settings"]
        settingsButton.tap()
        
        let indexedSearchSwitch = app.tables.switches["Indexed Search"]
        indexedSearchSwitch.tap()
        
        let doneButton = app.navigationBars["Settings"].buttons["Done"]
        doneButton.tap()
        settingsButton.tap()
        indexedSearchSwitch.tap()
        doneButton.tap()
        settingsButton.tap()
        indexedSearchSwitch.tap()
        doneButton.tap()
    }
    
    func testSearchBar(){
    
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let app = XCUIApplication()
        app.navigationBars["Contacts"].buttons["Settings"].tap()
        
        let searchbarSwitch = app.tables.switches["SearchBar"]
        searchbarSwitch.tap()
        searchbarSwitch.tap()
        app.navigationBars["Settings"].buttons["Done"].tap()
        
        let searchSearchField = app.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("john")
        
        let cancelButton = app.buttons["Cancel"]
        cancelButton.tap()
        searchSearchField.buttons["Clear text"].tap()
        cancelButton.tap()
    }
    
}
