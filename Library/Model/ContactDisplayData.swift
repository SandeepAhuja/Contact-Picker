//
//  ContactDisplayData.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation
import Contacts

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
