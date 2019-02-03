//
//  DFGAddressBookContactRoutine.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 14/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import Foundation
import Contacts

class DFGAddressBookContactRoutine: DFGAddressBookAccessBaseRoutine {
    var contactBuilder:DFGContactRecordBuilder
    override init(addressBook: DFGAddressBookWrapperRef) {
        self.contactBuilder = DFGContactRecordBuilder()
        super.init(addressBook: addressBook)
    }
    
    func contactWithRecordId(_ recordId:String,fieldMask:[DFGContactFields])->ContactDisplayItem?{
        var contactItem:ContactDisplayItem?
        if self.ref.errorRef == nil {
            if #available (iOS 9.0, *) {
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey] as [Any]
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys as! [CNKeyDescriptor])
                let predicate = CNContact.predicateForContacts(withIdentifiers: [recordId])
                fetchRequest.predicate = predicate
                do{
                    let store = self.ref.addressBook as! CNContactStore
                    try store.enumerateContacts(with: fetchRequest) {
                        contact, stop in
                        if let item:ContactDisplayItem = self.contactBuilder.contactWithRecord(contact, fieldMask: fieldMask){
                            contactItem = item
                        }
                    }
                    
                } catch let err{
                    print(err)
                }

            }
        }
        return contactItem
    }
    
    
    func allContactsWithContactFieldMask(_ fieldMask:[DFGContactFields])->[ContactDisplayItem]{
        var contacts = [ContactDisplayItem]()
        if self.ref.errorRef == nil{
            if #available (iOS 9.0,*){
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey] as [Any]
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys as! [CNKeyDescriptor])
                do{
                    let store = self.ref.addressBook as! CNContactStore
                    try store.enumerateContacts(with: fetchRequest) {
                        contact, stop in
                        if let item:ContactDisplayItem = self.contactBuilder.contactWithRecord(contact, fieldMask: fieldMask){
                            contacts.append(item)
                        }
                    }
                    
                } catch let err{
                    print(err)
                }

            }
        }
        
        return contacts
    }
    func thumbnailWithRecordId(_ recordId:NSNumber)->UIImage?{
        if self.ref.errorRef == nil {
            if #available (iOS 9.0, *){
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey] as [Any]
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys as! [CNKeyDescriptor])
                let predicate = CNContact.predicateForContacts(withIdentifiers: [recordId.stringValue])
                fetchRequest.predicate = predicate
                do{
                    let store = self.ref.addressBook as! CNContactStore
                    var image:UIImage?
                    try store.enumerateContacts(with: fetchRequest) {
                        contact, stop in
                        image = DFGImageExtractor.thumbnailWithRecordRef(contact)
                    }
                    return image
                } catch let err{
                    print(err)
                }
                
            }
        }
        return nil
    }

    func imageWithRecordId(_ recordId:NSNumber)->UIImage?{
        if self.ref.errorRef == nil {
            if #available (iOS 9.0, *){
                let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey] as [Any]
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys as! [CNKeyDescriptor])
                let predicate = CNContact.predicateForContacts(withIdentifiers: [recordId.stringValue])
                fetchRequest.predicate = predicate
                do{
                    let store = self.ref.addressBook as! CNContactStore
                    var image:UIImage?
                    try store.enumerateContacts(with: fetchRequest) {
                        contact, stop in
                        image = DFGImageExtractor.photoWithRecordRef(contact)
                    }
                    return image
                } catch let err{
                    print(err)
                }

            }
        }
        return nil
    }
    
    
}
