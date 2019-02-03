//
//  ContactDisplayDataTests.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 07/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import XCTest
@testable import ContactUtility

class ContactDisplayDataTests: XCTestCase {
       var sections:[ContactDisplayItem]?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sections = nil
        super.tearDown()
    }

//    func testWithNilSection() {
//        sections = []
//        for i in 1...1000 {
//            let item = ContactDisplayItem(recordId: String(i), firstName: self.randomStringWithLength(10), lastName: self.randomStringWithLength(10), phoneNumber: "1234567890")
//            sections?.append(item)
//        }
//        let data = ContactDisplayData.getIndexedContacts(<#T##ContactDisplayData#>)
//    }
    
    func randomStringWithLength (_ len : Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for i in 0..<len {
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.character(at: Int(rand)))
        }
        
        return randomString as String
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
