//
//  DFGContactListBuilder.swift
//  ContactUtility
//
//  Created by Hitesh on 15/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import Foundation

typealias DFGFilterContactBlock = (contact:ContactDisplayItem)->Bool

class DFGContactListBuilder: NSObject {
        var filterBlock : DFGFilterContactBlock?
        var sortDescriptors : [NSSortDescriptor]?
                
        func contactListWithAllContacts(allContacts: [ContactDisplayItem]) -> [ContactDisplayItem]? {
            var mutableContacts: [ContactDisplayItem] = allContacts
            mutableContacts = self.filterContacts(mutableContacts)!
            mutableContacts = self.sortContacts(mutableContacts)!
            return mutableContacts
            
        }
        
        func filterContacts(contacts: [ContactDisplayItem])->[ContactDisplayItem]? {
            if (self.filterBlock != nil) {
                var predicate: NSPredicate
                predicate = NSPredicate(block: { (contact, _) -> Bool in
                    return self.filterBlock!(contact: contact as! ContactDisplayItem)
                })
                return (contacts as NSArray).filteredArrayUsingPredicate(predicate) as? [ContactDisplayItem]
            }
            return contacts
        }

        func sortContacts(contacts: [ContactDisplayItem])->[ContactDisplayItem]? {
            if (self.sortDescriptors != nil) {
                return (contacts as NSArray).sortedArrayUsingDescriptors(self.sortDescriptors!) as?[ContactDisplayItem]
            }
            return contacts
        }
}
