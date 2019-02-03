//
//  DFGAddressBookWrapperRef.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 15/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import Contacts
class DFGAddressBookWrapperRef: NSObject {
    static let sharedInstance = DFGAddressBookWrapperRef()
    var addressBook : AnyObject? = nil
    var errorRef:NSError? = nil
    
    override init() {
        if #available(iOS 9.0,*){
            addressBook = CNContactStore()
        }
    }
}

