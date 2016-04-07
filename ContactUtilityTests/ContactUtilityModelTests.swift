//
//  ContactUtilityModelTests.swift
//  ContactUtility
//
//  Created by Hitesh on 07/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import XCTest
@testable import ContactUtility
class ContactUtilityModelTests: XCTestCase {
    var contactItem:ContactDisplayItem?
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        contactItem = nil
        super.tearDown()
    }
    
    func testContactItem(){
        contactItem = ContactDisplayItem(identifier: "124", givenName: "", familyName: "", phoneNumber: "")
        XCTAssertTrue(contactItem?.fullName == "No Name", "full name must be equal to no name")
        
    }
    func testModelWithEmptyIdentifier(){
        contactItem = ContactDisplayItem(identifier: "", givenName: "", familyName: "", phoneNumber: "")
        XCTAssertTrue(contactItem == nil, "object creation fallable to nil")
        
    }

    func testModelWithNilIdentifier(){
        contactItem = ContactDisplayItem(identifier: nil, givenName: "", familyName: "", phoneNumber: "")
        XCTAssertTrue(contactItem == nil, "object creation fallable to nil")
        
    }

    func testModelWithEmptyNames(){
        contactItem = ContactDisplayItem(identifier: "123", givenName: "", familyName: "", phoneNumber: "8467894040")
        XCTAssertTrue(contactItem?.fullName == "8467894040", "full name equals to phone number")
    }
    
    func testFullname(){
        let givenName = "sandeep"
        let familyName = "ahuja"
        contactItem = ContactDisplayItem(identifier: "123", givenName: givenName, familyName: familyName, phoneNumber: "8467894040")
        XCTAssertTrue(contactItem?.fullName == "sandeep ahuja", "full name equals sandeep ahuja")
    }
    
    func testModelWithNilValues(){
        contactItem = ContactDisplayItem(identifier: "123", givenName: nil, familyName: nil, phoneNumber: "8467894040")
        XCTAssertTrue(contactItem?.fullName == "8467894040", "full name equals to phone number")
    
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
