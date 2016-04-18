//
//  DFGAddressBookContactRoutine.swift
//  ContactUtility
//
//  Created by Hitesh on 14/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import Foundation
import AddressBook
import Contacts

class DFGAddressBookContactRoutine: DFGAddressBookAccessBaseRoutine {
    var contactBuilder:DFGContactRecordBuilder
    override init(addressBook: DFGAddressBookWrapperRef) {
        self.contactBuilder = DFGContactRecordBuilder()
        super.init(addressBook: addressBook)
    }
    
    func contactWithRecordId(recordId:String,fieldMask:[DFGContactFields])->ContactDisplayItem?{
        var contactItem:ContactDisplayItem?
        if self.ref.errorRef == nil {
            if #available (iOS 9.0, *) {
                let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey]
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys)
                let predicate = CNContact.predicateForContactsWithIdentifiers([recordId])
                fetchRequest.predicate = predicate
                do{
                    let store = self.ref.addressBook as! CNContactStore
                    try store.enumerateContactsWithFetchRequest(fetchRequest) {
                        contact, stop in
                        if let item:ContactDisplayItem = self.contactBuilder.contactWithRecord(contact, fieldMask: fieldMask){
                            contactItem = item
                        }
                    }
                    
                } catch let err{
                    print(err)
                }

            }else {
                if let recordRef:ABRecordRef = ABAddressBookGetPersonWithRecordID(self.ref.addressBook, Int32(recordId)! as ABRecordID).takeUnretainedValue() {
                    contactItem = self.contactBuilder.contactWithRecordRef(recordRef,fieldMask: fieldMask)
                }
            }
        }
        return contactItem
    }
    
    
    func allContactsWithContactFieldMask(fieldMask:[DFGContactFields])->[ContactDisplayItem]{
        var contacts = [ContactDisplayItem]()
        if self.ref.errorRef == nil{
            if #available (iOS 9.0,*){
                let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey]
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys)
                do{
                    let store = self.ref.addressBook as! CNContactStore
                    try store.enumerateContactsWithFetchRequest(fetchRequest) {
                        contact, stop in
                        if let item:ContactDisplayItem = self.contactBuilder.contactWithRecord(contact, fieldMask: fieldMask){
                            contacts.append(item)
                        }
                    }
                    
                } catch let err{
                    print(err)
                }

            }else {
                    if let allContacts = ABAddressBookCopyArrayOfAllPeople(self.ref.addressBook)?.takeRetainedValue(){

                        for contact in allContacts as NSArray {
                            if let item:ContactDisplayItem = self.contactBuilder.contactWithRecord(contact, fieldMask: fieldMask){
                                contacts.append(item)
                            }
                        }
                    }

                }
            }
        
        return contacts
    }
    func thumbnailWithRecordId(recordId:NSNumber)->UIImage?{
        if self.ref.errorRef == nil {
            if #available (iOS 9.0, *){
                let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey]
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys)
                let predicate = CNContact.predicateForContactsWithIdentifiers([recordId.stringValue])
                fetchRequest.predicate = predicate
                do{
                    let store = self.ref.addressBook as! CNContactStore
                    try store.enumerateContactsWithFetchRequest(fetchRequest) {
                        contact, stop in
                        return DFGImageExtractor.thumbnailWithRecordRef(contact)
                    }
                    
                } catch let err{
                    print(err)
                }
                
            }else {
                if let recordRef:ABRecordRef = ABAddressBookGetPersonWithRecordID(self.ref.addressBook, recordId.intValue).takeUnretainedValue(){
                    return DFGImageExtractor.thumbnailWithRecordRef(recordRef)
                }
            }
        }
        return nil
    }

    func imageWithRecordId(recordId:NSNumber)->UIImage?{
        if self.ref.errorRef == nil {
            if #available (iOS 9.0, *){
                let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey]
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys)
                let predicate = CNContact.predicateForContactsWithIdentifiers([recordId.stringValue])
                fetchRequest.predicate = predicate
                do{
                    let store = self.ref.addressBook as! CNContactStore
                    try store.enumerateContactsWithFetchRequest(fetchRequest) {
                        contact, stop in
                        return DFGImageExtractor.photoWithRecordRef(contact)
                    }
                    
                } catch let err{
                    print(err)
                }

            }else {
                if let recordRef:ABRecordRef = ABAddressBookGetPersonWithRecordID(self.ref.addressBook, recordId.intValue).takeUnretainedValue(){
                    return DFGImageExtractor.photoWithRecordRef(recordRef)
                }
            }
        }
        return nil
    }
    
    
}
