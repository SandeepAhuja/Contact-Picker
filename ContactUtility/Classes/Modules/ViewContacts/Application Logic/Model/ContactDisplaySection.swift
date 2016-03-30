//
//  ContactDisplaySection.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation

class ContactDisplaySection: NSObject {
    var name : String?
    var items : [ContactDisplayItem] = []
    
    init(name: String, items: [ContactDisplayItem]?) {
        self.name = name
        if (items != nil) {
            self.items = items!
//            self.items.unshare()
        }
    }

}
