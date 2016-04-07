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
        var collection:[ContactDisplayItem]?
        if let people = contacts {
            collection = getContacts(people) as? [ContactDisplayItem]
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
    
    public func getIndexedContacts(collection:[ContactDisplayItem])->[String: [ContactDisplayItem]]{
        var indexedAuthors = [String: [ContactDisplayItem]]()
        if collection.count > 0{
            for person in collection {
                if person.familyName?.isEmpty == true && person.givenName?.isEmpty == true {
                    let initialLetter = "#"
                    var authorArray = indexedAuthors[initialLetter] ?? [ContactDisplayItem]()
                    authorArray.append(person)
                    indexedAuthors[initialLetter] = authorArray
                    continue
                }else{
                    var initialLetter = ""
                    if person.familyName?.isEmpty == false{
                        initialLetter = person.familyName!.substringToIndex((person.familyName?.startIndex.advancedBy(1))!).uppercaseString
                    }else if person.givenName?.isEmpty == false{
                        initialLetter = person.givenName!.substringToIndex((person.givenName?.startIndex.advancedBy(1))!).uppercaseString
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
    
    func getContacts(contacts:[AnyObject])->[AnyObject]{
        var collection:[ContactDisplayItem] = []
        if #available(iOS 9, *){
            for contact in contacts{
                var phone:String?
                if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
                    for phoneNumber:CNLabeledValue in contact.phoneNumbers {
                        let a = phoneNumber.value as! CNPhoneNumber
                        phone = a.stringValue
                    }
                }
                if let item =  ContactDisplayItem(identifier: contact.identifier, givenName: contact.givenName, familyName: contact.familyName,phoneNumber:phone) as ContactDisplayItem?{
                    collection.append(item)
                }
            }
        }else {
            for contact in contacts{
                let currentContact: ABRecordRef = contact
                let givenName = ABRecordCopyValue(currentContact, kABPersonFirstNameProperty)?.takeRetainedValue() as? String ?? ""
                let familyName  = ABRecordCopyValue(currentContact, kABPersonLastNameProperty)?.takeRetainedValue() as? String ?? ""
                let identifier =  String(ABRecordGetRecordID(currentContact))
                let phoneNumbers:ABMultiValueRef = ABRecordCopyValue(contact, kABPersonPhoneProperty).takeRetainedValue()
                var phoneNumber:String = ""
                let numberOfPhoneNumbers:CFIndex = ABMultiValueGetCount(phoneNumbers)
                for var i = 0; i < numberOfPhoneNumbers; i++ {
                    phoneNumber = ABMultiValueCopyValueAtIndex(phoneNumbers, i).takeRetainedValue() as! String
                    break
                }
                
                if let item =  ContactDisplayItem(identifier: identifier, givenName: givenName, familyName: familyName, phoneNumber:phoneNumber) as ContactDisplayItem?{
                    collection.append(item)
                }
            }
        }
        return collection

    }

}
