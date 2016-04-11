//
//  ContactExtractor.swift
//  ContactUtility
//
//  Created by Hitesh on 08/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import AddressBook

class ContactExtractor: NSObject {
    var person: ABRecordRef?
    
    func name()->ContactName {
        let contactName = ContactName()
        contactName.firstName = self.stringProperty(kABPersonFirstNameProperty)
        contactName.lastName = self.stringProperty(kABPersonLastNameProperty)
        contactName.middleName = self.stringProperty(kABPersonMiddleNameProperty)
        contactName.fullName = self.compositeName()
        return contactName
    }
    
    private func stringProperty(propertyId:ABPropertyID)->String?{
        return ABRecordCopyValue(person, propertyId)?.takeRetainedValue() as? String
    }
    
    private func compositeName()->String?{
        return ABRecordCopyCompositeName(person)?.takeRetainedValue() as? String
    }
    
    func phonesWithLabels(needLabels: Bool) -> [AnyObject]? {
        return self.mapMultiValueOfProperty(kABPersonPhoneProperty, withBlock: {(multiValue: ABMultiValueRef, value: AnyObject?, index: CFIndex) -> AnyObject in
            var phone: ContactPhone?
            if value != nil {
                phone = ContactPhone()
                phone!.number = value as! String!
                if needLabels {
                    phone!.originalLabel = self.originalLabelFromMultiValue(multiValue, index: index)
                    phone!.localizedLabel = self.localizedLabelFromMultiValue(multiValue, index: index)
                }
            }
            return phone!
        })!
    }
    func localizedLabelFromMultiValue(multiValue: ABMultiValueRef, index: CFIndex) -> String {
        var label: String = ""
        let rawLabel: AnyObject? = ABMultiValueCopyLabelAtIndex(multiValue, index)?.takeRetainedValue()
        if let strLabel = rawLabel {
            label = ABAddressBookCopyLocalizedLabel(strLabel as! CFString).takeRetainedValue() as String
        }
        return label
    }
    func originalLabelFromMultiValue(multiValue: ABMultiValueRef, index: CFIndex) -> String? {
        if let rawLabel = ABMultiValueCopyLabelAtIndex(multiValue, index)?.takeRetainedValue() as? String {
            return rawLabel
        }
        return ""
    }
    func mapMultiValueOfProperty(property: ABPropertyID, withBlock block: (multiValue: ABMultiValueRef, value: AnyObject, index: CFIndex) -> AnyObject) -> [AnyObject]? {
        var array: [AnyObject] = [AnyObject]()
        let multiValue: ABMultiValueRef? = ABRecordCopyValue(self.person, property)?.takeRetainedValue()
        if multiValue != nil {
            let count: CFIndex = ABMultiValueGetCount(multiValue)
            for var i = 0; i < count; i++ {
                if let value = ABMultiValueCopyValueAtIndex(multiValue, i)?.takeRetainedValue(){
                    let object = block(multiValue: multiValue!, value: value, index: i)
                    if let finalobject:AnyObject = object {
                        array.append(finalobject)
                    }
                }
            }
        }
        
        if array.count > 0 {
            return NSArray(array:array, copyItems: true) as [AnyObject]
        }
        return []
    }}
