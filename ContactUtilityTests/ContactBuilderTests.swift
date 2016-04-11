//
//  ContactBuilderTests.swift
//  ContactUtility
//
//  Created by Hitesh on 11/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import XCTest
import AddressBook
@testable import ContactUtility
class ContactBuilderTests: XCTestCase {
    var addressBook:ABAddressBookRef?
    var recordBuilder:ContactRecordBuilder?
    override func setUp() {
        super.setUp()
            let stat = ABAddressBookGetAuthorizationStatus()
            switch stat {
            case .Denied, .Restricted:
                print("no access")
            case .Authorized, .NotDetermined:
                var err : Unmanaged<CFError>? = nil
                let adbk : ABAddressBook? = ABAddressBookCreateWithOptions(nil, &err).takeRetainedValue()
                if adbk == nil {
                    print(err)
                    return
                }
                ABAddressBookRequestAccessWithCompletion(adbk) {
                    (granted:Bool, err:CFError!) in
                    if granted {
                        self.addressBook = adbk
                    } else {
                        print(err)
                    }//if
                }//ABAddressBookReqeustAccessWithCompletion
            }//case
        recordBuilder = ContactRecordBuilder()
        recordBuilder?.extractor = ContactExtractor()
    }
    
    override func tearDown() {
        addressBook = nil
        recordBuilder = nil        
        super.tearDown()
    }
    
    
    
    
    func testExample() {
        let newContact:ABRecordRef! = ABPersonCreate().takeRetainedValue()
        var success:Bool = false
        let newFirstName:String = "FirstName"
        let newLastName = "lastName"
        var error: Unmanaged<CFErrorRef>? = nil
        success = ABRecordSetValue(newContact, kABPersonFirstNameProperty, newFirstName, &error)
        success = ABRecordSetValue(newContact, kABPersonLastNameProperty, newLastName, &error)
        success = ABAddressBookAddRecord(self.addressBook, newContact, &error)
        success = ABAddressBookSave(self.addressBook, &error)
        
        let item:ContactDisplayItem? = recordBuilder?.contactWithRecordRef(newContact)
        XCTAssert(item?.name?.firstName == "FirstName", "")
        XCTAssert(item?.name?.lastName == "lastName", "")
    }
    
    
    
}
