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
    
    func presentSettingsInterface(){
        contactWireFrame?.presentSettings()
    }
    func showError(message: NSError?){
        contactWireFrame?.presentAlertContoller(message)
    }
    
    func showContacts(contacts:ContactDisplayData?){
        if contacts?.sections?.count == 0 {
            dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                self.userInterface?.showNoContentMessage()
            })
        }else{
            if (contacts != nil) {
                dispatch_async(dispatch_get_main_queue(), { [unowned self]() -> Void in
                    self.userInterface?.showFetchedContactsData(contacts!)
                })
            }
        }
    }
    
    
}
