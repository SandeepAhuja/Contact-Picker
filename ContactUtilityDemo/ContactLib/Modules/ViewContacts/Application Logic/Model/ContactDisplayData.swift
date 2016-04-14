//
//  ContactDisplayData.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
import Contacts
import AddressBook

class ContactDisplayData: NSObject {
    var sections:[ContactDisplaySection]?
    var allKeys:[String]?
    init(section:[ContactDisplaySection],key:[String]) {
        self.sections = section
        self.allKeys = key
    }
    convenience init?(sections:[ContactDisplaySection]?,keys:[String]?){
        guard let _ = sections, let keys = keys else{
            return nil
        }
        self.init(section: sections!, key: keys)
    }
    
}
