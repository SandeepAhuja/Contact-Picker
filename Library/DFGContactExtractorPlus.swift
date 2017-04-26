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
        contactName.fullName = CNContactFormatter.stringFromContact(contact!, style: .FullName)
        return contactName
    }
    
    func emailWithLabels(flag:Bool){
    
    }
    
    
    func phonesWithLabels(flag:Bool)->[ContactPhone]?{
        if (contact!.isKeyAvailable(CNContactPhoneNumbersKey)) {
            var phones:[ContactPhone] = []
            for phoneNumber:CNLabeledValue in contact!.phoneNumbers {
                let a = phoneNumber.value as! CNPhoneNumber
                let phone = ContactPhone()
                phone.number = a.stringValue
                phone.originalLabel = phoneNumber.label
                phone.localizedLabel = CNLabeledValue.localizedStringForLabel(phoneNumber.label)
                print("\(phone.localizedLabel)")
                phones.append(phone)
            }
            return phones
        }
        return nil
    }
}

