//
//  DFGContactRecordBuilder.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 15/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit

import Contacts

class DFGContactRecordBuilder: NSObject {
    var extractor:AnyObject
    
    override init() {        
        self.extractor = DFGContactExtractorPlus()
        super.init()
    }
    
    func contactWithRecord(_ record:CNContact,fieldMask:[DFGContactFields])->ContactDisplayItem?{
        return self.contactWithCNContact(record,fieldMask: fieldMask)
    }
    
    
    @available(iOS 9.0, *)
    func contactWithCNContact(_ contact:CNContact,fieldMask:[DFGContactFields])->ContactDisplayItem? {
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
    
    class func getIndexedContacts(_ collection:[ContactDisplayItem])->[String: [ContactDisplayItem]]{
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
                        initialLetter = (person.name?.lastName?.substring(to: 1).uppercased())!
                    }else if person.name?.firstName?.isEmpty == false{
                        initialLetter = (person.name?.firstName?.substring(to: 1).uppercased())!
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
    
   class func contactDisplayData(_ contacts:[ContactDisplayItem]?)->ContactDisplayData?{
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
                
                sections.sort{$0.name!.compare ($1.name!) == .orderedAscending}
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

