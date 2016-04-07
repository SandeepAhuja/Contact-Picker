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
    var phoneNumber:String?
    var fullName :String{
        get{
            
            if familyName?.isEmpty == true && givenName?.isEmpty == true {
                if phoneNumber?.isEmpty == false{
                    return phoneNumber!
                }else{
                    return "No Name"
                }
            }
            
            var name = givenName
            if familyName?.isEmpty == false{
                name = name! + " " + familyName!
            }
            
            return name!
        }
    }
    init(identifier:String!,givenName:String?,familyName:String?,phoneNumber:String?){
        self.identifier = identifier
        self.givenName = givenName
        self.familyName = familyName
        self.phoneNumber = phoneNumber
    }
}
