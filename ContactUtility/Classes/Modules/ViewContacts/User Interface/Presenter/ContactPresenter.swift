//
//  ContactPresenter.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import AddressBook

class ContactPresenter: NSObject,ContactInteractorOutput,ContactModuleInterface {    
    var contactInteractor: ContactInteractorInput?
    var contactWireFrame: ContactWireFrame?
    var userInterface : ContactViewInterface?
    let contactBuilder : DFGContactRecordBuilder = DFGContactRecordBuilder()
    
//    func searchContacts(searchSting:String){
//        contactInteractor?.fetchContacts(searchSting)
//    }
//    
//    func updateContacts(){
//        contactInteractor?.fetchContacts(.None)
//    }
//    
//    func showError(message: NSError?) {
//        contactWireFrame?.presentAlertContoller(message)
//    }
    
//    func showFilteredContacts(contacts:[AnyObject]?){
//        if  let people = contacts{
//            let contactDisplayItems = self.contactBuilder.contactDisplayItemsCollection(people)
//            dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
//                self.userInterface?.updateFilteredContacts(contactDisplayItems)
//                })
//        }//end of if
//    }
    
//    func showContacts(contacts:[AnyObject]?){
//        if  let people = contacts where people.count > 0 {
//            let contactDisplayData = self.contactBuilder.contactDisplayData(people)
//            dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
//                self.userInterface?.showFetchedContactsData(contactDisplayData)
//            })
//        }else{
//            dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
//                self.userInterface?.showNoContentMessage()
//            })
//        }
//    }
}