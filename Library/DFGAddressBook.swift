                                                                                                                                                                        //
//  DFGAddressBook.swift
//  ContactUtility
//
//  Created by Hitesh on 14/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class DFGAddressBook: NSObject {
    var accessRoutine : DFGAddressBookAccessRoutine!
    var contactRoutine : DFGAddressBookContactRoutine!
    var filterBlock : DFGFilterContactBlock?
    var sortDescriptors: [NSSortDescriptor]?
    var fieldsMask:[DFGContactFields]!
    override init() {
        super.init()
        self.fieldsMask = DFGContactFields.DFGContactFieldDefault
        let refWrapper:AddressBookWrapperRef = AddressBookWrapperRef.sharedInstance
        self.accessRoutine = DFGAddressBookAccessRoutine(addressBook: refWrapper)
        if refWrapper.errorRef == nil {
            self.contactRoutine = DFGAddressBookContactRoutine(addressBook: refWrapper)
        }else{
            print("Addressbook initialization error: + \(refWrapper.errorRef?.localizedDescription)")
        }
    }
    
    class  func access()->DFGAddressBookAccess {
        return DFGAddressBookAccessRoutine.accessStatus()
    }
    
    func loadContacts(completion:(([ContactDisplayItem]?,NSError?) -> Void)?){
        let listBuilder: DFGContactListBuilder = DFGContactListBuilder()
        listBuilder.filterBlock = self.filterBlock
        listBuilder.sortDescriptors = self.sortDescriptors
        self.accessRoutine.requestAccessWithCompletion({[unowned self] (granted, error) -> Void in
            if granted {
                var contacts : [ContactDisplayItem] = self.contactRoutine.allContactsWithContactFieldMask(self.fieldsMask)
                contacts = listBuilder.contactListWithAllContacts(contacts)
                completion?(contacts,error)
            }
        })

    }

    func loadContactByRecordID(recordId:NSNumber,completion:((ContactDisplayItem?,NSError?) -> Void)?){
        
    }

    func loadPhotoByRecordID(recordId:NSNumber,completion:((UIImage?,NSError?) -> Void)?){
        
    }
    
}
