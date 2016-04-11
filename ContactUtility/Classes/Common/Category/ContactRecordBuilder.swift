//
//  ContactRecordBuilder.swift
//  ContactUtility
//
//  Created by Hitesh on 08/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import AddressBook
import Contacts

class ContactRecordBuilder: NSObject {
    var extractor:AnyObject?
    
    
    required override init(){
        if #available(iOS 9, *){
            extractor = ContactExtractorPlus()
        }else{
            extractor = ContactExtractor()
        }
    }
    
    
    func contactWithRecord(record:AnyObject)->ContactDisplayItem?{
        if #available(iOS 9.0, *) {
            return self.contactWithCNContact(record as! CNContact)
        } else {
            // Fallback on earlier versions
            return self.contactWithRecordRef(record as ABRecordRef)
        }
    }
    
    func contactWithRecordRef(recordRef:ABRecordRef)->ContactDisplayItem?{
        let localExtractor:ContactExtractor = self.extractor as! ContactExtractor
        localExtractor.person = recordRef
        let contactItem = ContactDisplayItem()
        contactItem.identifier = String(ABRecordGetRecordID(recordRef))
        contactItem.name = localExtractor.name()
        contactItem.phones = localExtractor.phonesWithLabels(true) as? [ContactPhone]
        contactItem.thumbnailImage = ImageExtractor.thumbnailWithRecordRef(recordRef)
        return contactItem
    }
    
    @available(iOS 9.0, *)
    func contactWithCNContact(contact:CNContact)->ContactDisplayItem?{
        let localExtractor:ContactExtractorPlus = self.extractor as! ContactExtractorPlus
        localExtractor.contact = contact
        let contactItem = ContactDisplayItem()
        contactItem.identifier = contact.identifier
        contactItem.name = localExtractor.name()
        contactItem.phones = localExtractor.phonesWithLabels(true)
        contactItem.thumbnailImage = ImageExtractor.thumbnailWithRecordRef(contact)
        return contactItem
    }
}
