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
    var contactBuilder:ContactRecordBuilder
    override init(addressBook: AddressBookWrapperRef) {
        self.contactBuilder = ContactRecordBuilder()
        super.init(addressBook: addressBook)
    }
    
    func contactWithRecordId(recordId:NSNumber,fieldMask:DFGContactFields)->ContactDisplayItem?{
        if self.ref.errorRef == nil{
            if let recordRef:ABRecordRef = ABAddressBookGetPersonWithRecordID(self.ref.addressBook, recordId.intValue as ABRecordID).takeUnretainedValue() {
                return self.contactBuilder.contactWithRecordRef(recordRef,fieldMask: fieldMask)
            }
        }
        return nil
    }
    
    /*
    - (NSArray *)allContactsWithContactFieldMask:(APContactField)fieldMask
    {
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    if (!self.wrapper.error)
    {
    CFArrayRef peopleArrayRef = ABAddressBookCopyArrayOfAllPeople(self.wrapper.ref);
    CFIndex count = CFArrayGetCount(peopleArrayRef);
    for (CFIndex i = 0; i < count; i++)
    {
    ABRecordRef recordRef = CFArrayGetValueAtIndex(peopleArrayRef, i);
    APContact *contact = [self.builder contactWithRecordRef:recordRef fieldMask:fieldMask];
    [contacts addObject:contact];
    }
    CFRelease(peopleArrayRef);
    }
    return contacts.count > 0 ? contacts.copy : nil;
    }
    */
    
    func allContactsWithContactFieldMask(fieldMask:DFGContactFields,searchQuery:String?)->[ContactDisplayItem]{
        var contacts = [ContactDisplayItem]()
        if self.ref.errorRef == nil{
            if #available (iOS 9.0,*){
                let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey]
                var contacts = [CNContact]()
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys)
                if let name = searchQuery {
                    if name.characters.count > 0{
                        let predicate = CNContact.predicateForContactsMatchingName(name )
                        fetchRequest.predicate = predicate
                    }
                }
                
                do{
                    let store = self.ref.addressBook as! CNContactStore
                    try store.enumerateContactsWithFetchRequest(fetchRequest) {
                        contact, stop in
                        if let item:ContactDisplayItem = self.contactBuilder.contactWithRecord(contact, fieldMask: fieldMask){
                            contacts.
                        }
                    }
                    
                } catch let err{
                    print(err)
                }

            }else{
                if let allContacts = ABAddressBookCopyArrayOfAllPeople(self.ref.addressBook)?.takeRetainedValue(){
                    let count:CFIndex = CFArrayGetCount(allContacts)
                    for var i:CFIndex = 0;i < count; i++ {
                        let recordRef:ABRecordRef = CFArrayGetValueAtIndex(allContacts, i) as! ABRecordRef
                        if let item:ContactDisplayItem = self.contactBuilder.contactWithRecord(recordRef, fieldMask: fieldMask){
                            contacts.append(item)
                        }
                    }
                }
            }
            
        }
        return contacts
    }
    
    func imageWithRecordId(recordId:String)->UIImage{
    
    }
}
