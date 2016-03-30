//
//  ContactDisplayItem.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
class ContactDisplayItem: NSObject {
    var identifier:String!
    var givenName:String?
    var familyName:String?
    init(identifier:String!,givenName:String?,familyName:String?){
        self.identifier = identifier
        self.givenName = givenName
        self.familyName = familyName
    }
}
