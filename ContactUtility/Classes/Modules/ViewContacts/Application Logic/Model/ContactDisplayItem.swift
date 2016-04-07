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
    var fullName :String?{
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
            
            if let compositeName = name where !compositeName.isEmpty{
                return compositeName
            }else{
                if phoneNumber?.isEmpty == false{
                    return phoneNumber!
                }else{
                    return "No Name"
                }
            }
            
        }
    }
    init(recordId:String!,firstName:String?,lastName:String?,phoneNumber:String?){
        self.identifier = recordId
        self.givenName = firstName ?? ""
        self.familyName = lastName ?? ""
        self.phoneNumber = phoneNumber ?? ""
    }
    
    convenience init?(identifier:String!,givenName:String?,familyName:String?,phoneNumber:String?){
        guard let recordId = identifier where !identifier.isEmpty else{
            return nil
        }
        self.init(recordId: recordId, firstName: givenName, lastName: familyName, phoneNumber: phoneNumber)
    }
}
