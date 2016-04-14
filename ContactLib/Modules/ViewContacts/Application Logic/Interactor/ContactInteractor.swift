//
//  ContactInteractor.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import AddressBookUI
class ContactInteractor: NSObject, ContactInteractorInput{
    var output:ContactInteractorOutput?
    var contactManager: ContactDataManager
    init(contactManager:ContactDataManager){
        self.contactManager = contactManager
    }
    
    func fetchContacts(searchQuery:String?){
        self.contactManager.fetchAllContacts(searchQuery ,completion: { [unowned self] people,error in
            if (error == nil) {
                if let search = searchQuery where search.characters.count > 0 {
                    self.output?.showFilteredContacts(people)
                }else{
                    self.output?.showContacts(people)
                }
            }else{
                self.output?.showError(error)
            }
        })
    }
}
