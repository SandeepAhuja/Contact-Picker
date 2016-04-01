//
//  ContactDisplaySection.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
let sectionvalidNames:[String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","W","X","Y","Z"]

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
