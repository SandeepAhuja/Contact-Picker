//
//  DFGContactRecordBuilder.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 15/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import AddressBook
import Contacts

class DFGContactRecordBuilder: NSObject {
    var extractor:AnyObject
    
    override init() {
        if #available(iOS 9.0, *) {
            extractor = DFGContactExtractorPlus()
        } else {
            extractor = DFGContactExtractor()
        }
    }
    
    func contactWithRecord(record:AnyObject,fieldMask:[DFGContactFields])->ContactDisplayItem?{
        if #available(iOS 9.0, *) {
            return self.contactWithCNContact(record as! CNContact,fieldMask: fieldMask)
        } else {
            // Fallback on earlier versions
            return self.contactWithRecordRef(record as ABRecordRef,fieldMask: fieldMask)
        }
    }
    
    func contactWithRecordRef(recordRef:ABRecordRef,fieldMask:[DFGContactFields])->ContactDisplayItem?{
        let localExtractor:DFGContactExtractor = self.extractor as! DFGContactExtractor
        localExtractor.person = recordRef
        let contactItem = ContactDisplayItem()
        contactItem.identifier = String(ABRecordGetRecordID(recordRef))
        if (fieldMask.contains(DFGContactFields.DFGContactFieldName)){
            contactItem.name = localExtractor.name()
        }
        if (fieldMask.contains(DFGContactFields.DFGContactFieldPhonesOnly) || (fieldMask.contains(DFGContactFields.DFGContactFieldPhonesWithLabels))){
            contactItem.phones = localExtractor.phonesWithLabels(true) as? [ContactPhone]
        }
        if fieldMask.contains(DFGContactFields.DFGContactFieldThumbnail){
            contactItem.thumbnailImage = DFGImageExtractor.thumbnailWithRecordRef(recordRef)
        }
        
        return contactItem
    }
    
    @available(iOS 9.0, *)
    func contactWithCNContact(contact:CNContact,fieldMask:[DFGContactFields])->ContactDisplayItem? {
        let localExtractor:DFGContactExtractorPlus = self.extractor as! DFGContactExtractorPlus
        localExtractor.contact = contact
        let contactItem = ContactDisplayItem()
        contactItem.identifier = contact.identifier
        
        if (fieldMask.contains(DFGContactFields.DFGContactFieldName)){
            contactItem.name = localExtractor.name()
        }
        if (fieldMask.contains(DFGContactFields.DFGContactFieldPhonesOnly) || (fieldMask.contains(DFGContactFields.DFGContactFieldPhonesWithLabels))){
            contactItem.phones = localExtractor.phonesWithLabels(true)
        }
        if fieldMask.contains(DFGContactFields.DFGContactFieldThumbnail){
            contactItem.thumbnailImage = DFGImageExtractor.thumbnailWithRecordRef(contact)
        }
        return contactItem
    }
    
    class func getIndexedContacts(collection:[ContactDisplayItem])->[String: [ContactDisplayItem]]{
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
    
   class func contactDisplayData(contacts:[ContactDisplayItem]?)->ContactDisplayData?{
        var contactDisplayData:ContactDisplayData? = nil
        if let people = contacts {
            if people.count > 0 {
                let indexedAuthors = self.getIndexedContacts(people)
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

