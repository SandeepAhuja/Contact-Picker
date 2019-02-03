//
//  DFGContactExtractorPlus.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 15/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import Contacts
@available(iOS 9.0, *)
class DFGContactExtractorPlus: NSObject {
    var contact: CNContact?
    func name()->ContactName {
        let contactName = ContactName()
        contactName.firstName = contact?.givenName
        contactName.lastName = contact?.familyName
        contactName.middleName = contact?.middleName
        contactName.fullName = CNContactFormatter.string(from: contact!, style: .fullName)
        return contactName
    }
    
    func emailWithLabels(_ flag:Bool){
    
    }
    
    
    func phonesWithLabels(_ flag:Bool)->[ContactPhone]?{
        if (contact!.isKeyAvailable(CNContactPhoneNumbersKey)) {
            var phones:[ContactPhone] = []
            for phoneNumber:CNLabeledValue in contact!.phoneNumbers {
                let a = phoneNumber.value 
                let phone = ContactPhone()
                phone.number = a.stringValue
                phone.originalLabel = phoneNumber.label
                phone.localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: phoneNumber.label!) as String                
                phones.append(phone)
            }
            return phones
        }
        return nil
    }
}

