                                                                                                                                                                        //
//  DFGAddressBook.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 14/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
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
        let refWrapper : DFGAddressBookWrapperRef = DFGAddressBookWrapperRef.sharedInstance
        self.accessRoutine = DFGAddressBookAccessRoutine(addressBook: refWrapper)
        if refWrapper.errorRef == nil {
            self.contactRoutine = DFGAddressBookContactRoutine(addressBook: refWrapper)
        }else{
            print("Addressbook initialization error: + \(String(describing: refWrapper.errorRef?.localizedDescription))")
        }
    }
    
    class  func access()->DFGAddressBookAccess {
        return DFGAddressBookAccessRoutine.accessStatus()
    }
    
    func loadContacts(_ completion:(([ContactDisplayItem]?,Error?) -> Void)?){
        let listBuilder: DFGContactListBuilder = DFGContactListBuilder()
        listBuilder.filterBlock = self.filterBlock
        listBuilder.sortDescriptors = self.sortDescriptors
        self.accessRoutine.requestAccessWithCompletion({[unowned self] (granted, error) -> Void in
            if granted {
                var contacts : [ContactDisplayItem] = self.contactRoutine.allContactsWithContactFieldMask(self.fieldsMask)
                contacts = listBuilder.contactListWithAllContacts(contacts)!
                completion?(contacts,error)
            }
        })

    }

    func loadContactByRecordID(_ recordId:String,completion:((ContactDisplayItem?,NSError?) -> Void)?){
        
        if let contact = self.contactRoutine.contactWithRecordId(recordId, fieldMask: self.fieldsMask){
            completion?(contact,nil)
        }
        
    }

    func loadPhotoByRecordID(_ recordId:NSNumber,completion:((UIImage?,NSError?) -> Void)?){
        
    }
    
}
