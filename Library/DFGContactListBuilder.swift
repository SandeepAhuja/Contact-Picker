//
//  DFGContactListBuilder.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 15/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import Foundation

typealias DFGFilterContactBlock = (_ contact:ContactDisplayItem)->Bool

class DFGContactListBuilder: NSObject {
        var filterBlock : DFGFilterContactBlock?
        var sortDescriptors : [NSSortDescriptor]?
                
        func contactListWithAllContacts(_ allContacts: [ContactDisplayItem]) -> [ContactDisplayItem]? {
            var mutableContacts: [ContactDisplayItem] = allContacts
            mutableContacts = self.filterContacts(mutableContacts)!
            mutableContacts = self.sortContacts(mutableContacts)!
            return mutableContacts
            
        }
        
        func filterContacts(_ contacts: [ContactDisplayItem])->[ContactDisplayItem]? {
            if (self.filterBlock != nil) {
                var predicate: NSPredicate
                predicate = NSPredicate(block: { (contact, _) -> Bool in
                    return self.filterBlock!(contact as! ContactDisplayItem)
                })
                return (contacts as NSArray).filtered(using: predicate) as? [ContactDisplayItem]
            }
            return contacts
        }

        func sortContacts(_ contacts: [ContactDisplayItem])->[ContactDisplayItem]? {
            if (self.sortDescriptors != nil) {
                return (contacts as NSArray).sortedArray(using: self.sortDescriptors!) as?[ContactDisplayItem]
            }
            return contacts
        }
}
