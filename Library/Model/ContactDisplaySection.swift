//
//  ContactDisplaySection.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation
let sectionvalidNames:[String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

class ContactDisplaySection: NSObject {
    var name : String?
    var items : [ContactDisplayItem] = []
    override init() {
        
    }
    
    init(sectionName: String, sectionItems: [ContactDisplayItem]) {
        self.name = sectionName
        self.items = sectionItems
    }
    
    convenience init?(name: String?, items: [ContactDisplayItem]?) {
        guard let sectionName = name where !sectionName.isEmpty else{
            return nil
        }
        guard let sectionItems = items where sectionItems.count > 0 else{
            return nil
        }
        self.init(sectionName: name!,sectionItems: items!)
    }
}
