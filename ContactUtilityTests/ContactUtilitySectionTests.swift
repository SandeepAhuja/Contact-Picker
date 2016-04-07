//
//  ContactUtilitySectionTests.swift
//  ContactUtility
//
//  Created by Hitesh on 07/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import XCTest
@testable import ContactUtility
class ContactUtilitySectionTests: XCTestCase {
    var section:ContactDisplaySection?
    var item:ContactDisplayItem?
    override func setUp() {
        super.setUp()
        item = ContactDisplayItem(identifier: "S", givenName: "A", familyName: "Ahuja", phoneNumber: "1231243241")
        
    }
    
    override func tearDown() {
        section = nil
        item = nil
        super.tearDown()
    }
    
    func testSectionWithNilValues() {
        section = ContactDisplaySection(name: nil, items: nil)
        XCTAssertTrue(section == nil, "object fallable to nil")
    }
    
    func testSectionState() {
        section = ContactDisplaySection(name:"A", items:[item!])
        XCTAssertTrue(section?.name == "A", "section name equals to A")
        XCTAssertTrue(section?.items.count == 1, "section items equals to 1")
    }
    
    func testSectionStateWithNameNilValue(){
        section = ContactDisplaySection(name: nil, items: [item!])
        XCTAssertTrue(section == nil, "object fallable to nil")
    }

    func testSectionStateWithItemsCountEqualToZero(){
        section = ContactDisplaySection(name: "A", items: [])
        XCTAssertTrue(section == nil, "object fallable to nil")
    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
