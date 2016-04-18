//
//  DFGAddressBookWrapperRef.swift
//  ContactUtility
//
//  Created by Hitesh on 15/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import AddressBook
import Contacts
class DFGAddressBookWrapperRef: NSObject {
    var addressBook : AnyObject? = nil
    var errorRef:NSError? = nil
    
    class var sharedInstance: DFGAddressBookWrapperRef {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: DFGAddressBookWrapperRef? = nil
            
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = DFGAddressBookWrapperRef()
            
        }
        return Static.instance!
    }
    
    override init() {
        if #available(iOS 9.0,*){
            addressBook = CNContactStore()
        }else{
            var error: Unmanaged<CFError>?
            guard let addressBook = ABAddressBookCreateWithOptions(nil, &error)?.takeRetainedValue() else {
                self.errorRef = error?.takeRetainedValue() as NSError?
                return
            }
            self.addressBook = addressBook
        }
    }
}

