//
//  ContactPresenter.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import AddressBook.ABAddressBook
class ContactPresenter: NSObject,ContactInteractorOutput,ContactModuleInterface {
    var contactInteractor: ContactInteractorInput?
    var contactWireFrame: ContactWireFrame?
    var userInterface : ContactViewInterface?
    
    func updateView(){
        contactInteractor?.fetchContacts()
    }
    
    func showError(message: NSError?){
        contactWireFrame?.presentAlertContoller(message)
    }
    func showContacts(contacts:[AnyObject]){
        for contact in contacts {
            let fname = ABRecordCopyValue(contact, kABPersonFirstNameProperty)?.takeRetainedValue() as? NSString
            let lname = ABRecordCopyValue(contact, kABPersonLastNameProperty)?.takeRetainedValue() as? NSString
            let name = String(fname) + " " + String(lname)
            print(name)
        }
    }
    
    
}
