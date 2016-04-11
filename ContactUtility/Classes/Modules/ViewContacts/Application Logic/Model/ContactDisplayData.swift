//
//  ContactDisplayData.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
import Contacts
import AddressBook

class ContactDisplayData: NSObject {
    var sections:[ContactDisplaySection]?
    var allKeys:[String]?
    init(contacts:[AnyObject]){
        super.init()
        self.contactDisplayData(contacts)
    }
    func contactDisplayData(contacts:[AnyObject]?) {
        var collection:[ContactDisplayItem]? = []
        let contactBuilder = ContactRecordBuilder()
        for contact in contacts! {
            if let item:ContactDisplayItem = contactBuilder.contactWithRecord(contact){
                collection!.append(item)
            }
        }
        
        var indexedAuthors:[String: [ContactDisplayItem]]?
        if collection != nil{
            indexedAuthors = getIndexedContacts(collection!)
        }
        
        self.sections = [ContactDisplaySection]()
        for (key,value) in indexedAuthors! {
            if let section = ContactDisplaySection(name: key, items: value as [ContactDisplayItem]){
                self.sections?.append(section)
            }
        }
            
        self.sections?.sortInPlace{$0.name!.compare ($1.name!) == .OrderedAscending}
        if let section = self.sections?.first {
            if section.name == "#" {
                if self.sections?.count > 0{
                    self.sections?.removeFirst()
                }
                self.sections?.append(section)
            }
        }
        self.allKeys = [String]()
        for section in self.sections!{
            self.allKeys?.append(section.name!)
        }
    }
    
    internal func getIndexedContacts(collection:[ContactDisplayItem])->[String: [ContactDisplayItem]]{
        var indexedAuthors = [String: [ContactDisplayItem]]()
        if collection.count > 0{
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
    
}
