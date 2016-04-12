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
    
    override init() {
        if #available(iOS 9.0, *) {
            extractor = ContactExtractorPlus()
        } else {
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
    func contactWithCNContact(contact:CNContact)->ContactDisplayItem? {
        let localExtractor:ContactExtractorPlus = self.extractor as! ContactExtractorPlus
        localExtractor.contact = contact
        let contactItem = ContactDisplayItem()
        contactItem.identifier = contact.identifier
        contactItem.name = localExtractor.name()
        contactItem.phones = localExtractor.phonesWithLabels(true)
        contactItem.thumbnailImage = ImageExtractor.thumbnailWithRecordRef(contact)
        return contactItem
    }
    
    func getIndexedContacts(collection:[ContactDisplayItem])->[String: [ContactDisplayItem]]{
        var indexedAuthors = [String: [ContactDisplayItem]]()
        if collection.count > 0 {
            for person in collection {
                if person.name?.lastName?.isEmpty == true && person.name?.firstName?.isEmpty == true {
                    let initialLetter = "#"
                    var authorArray = indexedAuthors[initialLetter] ?? [ContactDisplayItem]()
                    authorArray.append(person)
                    indexedAuthors[initialLetter] = authorArray
                    continue
                }else{
                    var initialLetter = ""
                    if person.name?.lastName?.isEmpty == false{
                        initialLetter = (person.name?.lastName!.substringToIndex((person.name!.lastName?.startIndex.advancedBy(1))!).uppercaseString)!
                    }else if person.name?.firstName?.isEmpty == false{
                        initialLetter = (person.name?.firstName!.substringToIndex((person.name?.firstName!.startIndex.advancedBy(1))!).uppercaseString)!
                    }
                    
                    if sectionvalidNames.contains(initialLetter) {
                        var authorArray = indexedAuthors[initialLetter] ?? [ContactDisplayItem]()
                        authorArray.append(person)
                        indexedAuthors[initialLetter] = authorArray
                    }else{
                        let initialLetter = "#"
                        var authorArray = indexedAuthors[initialLetter] ?? [ContactDisplayItem]()
                        authorArray.append(person)
                        indexedAuthors[initialLetter] = authorArray
                    }
                    
                }
                
            }
        }
        return indexedAuthors
    }

    func contactDisplayItemsCollection(contacts:[AnyObject]) -> [ContactDisplayItem]{
        var collection:[ContactDisplayItem] = []
        for contact in contacts {
            if let item:ContactDisplayItem = self.contactWithRecord(contact){
                collection.append(item)
            }
        }
        return collection
    }
    
    func contactDisplayData(contacts:[AnyObject]?)->ContactDisplayData?{
        var contactDisplayData:ContactDisplayData? = nil
        if let people = contacts {
            var collection:[ContactDisplayItem] = []
            
            for contact in people {
                if let item:ContactDisplayItem = self.contactWithRecord(contact){
                    collection.append(item)
                }
            }
            
            if collection.count > 0 {
                let indexedAuthors = self.getIndexedContacts(collection)
                var sections = [ContactDisplaySection]()
                for (key,value) in indexedAuthors {
                    if let section = ContactDisplaySection(name: key, items: value as [ContactDisplayItem]){
                        sections.append(section)
                    }
                }//end of for loop
                    
                sections.sortInPlace{$0.name!.compare ($1.name!) == .OrderedAscending}
                if let section = sections.first {
                    if section.name == "#" {
                        if sections.count > 0{
                            sections.removeFirst()
                        }
                        sections.append(section)
                    }
                }//end of if
                
                var allKeys = [String]()
                for section in sections{
                    if let name = section.name{
                        allKeys.append(name)
                    }//end of if
                }//end of for loop
                contactDisplayData = ContactDisplayData(sections: sections, keys: allKeys)
            }//end of if
            
        }//end of if
        return contactDisplayData
    }
    
}
