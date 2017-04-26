//
//  ContactUtilitySectionTests.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 07/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import XCTest
@testable import ContactUtility
class ContactUtilitySectionTests: XCTestCase {
    var section:ContactDisplaySection?
    var item:ContactDisplayItem?
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        section = nil
       
        super.tearDown()
    }
    
    func testSectionWithNilValues() {
        section = ContactDisplaySection(name: nil, items: nil)
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
