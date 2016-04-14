//
//  ContactExtractorPlus.swift
//  ContactUtility
//
//  Created by Hitesh on 08/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import Contacts
@available(iOS 9.0, *)
class ContactExtractorPlus: NSObject {
    var contact: CNContact?
    func name()->ContactName {
        let contactName = ContactName()
        contactName.firstName = contact?.givenName
        contactName.lastName = contact?.familyName
        contactName.middleName = contact?.middleName
        contactName.fullName = CNContactFormatter.stringFromContact(contact!, style: .FullName)
        return contactName
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
