//
//  ContactDisplayItem.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
class ContactDisplayItem: NSObject {
    var identifier:String?
    var givenName:String?
    var familyName:String?
    var fullName :String{
        get{
            
            if familyName?.isEmpty == true && givenName?.isEmpty == true {
                return "No Name"
            }
            
            var name = givenName
            if familyName?.isEmpty == false{
                name = name! + " " + familyName!
            }
            
            return name!
        }
    }
   convenience init?(identifier:String!,givenName:String?,familyName:String?){
    guard let firstName = givenName where !firstName.isEmpty, let lastname = familyName where !lastname.isEmpty else{
        return nil
    }
        self.init()
        self.identifier = identifier
        self.givenName = givenName
        self.familyName = familyName
    }
}
