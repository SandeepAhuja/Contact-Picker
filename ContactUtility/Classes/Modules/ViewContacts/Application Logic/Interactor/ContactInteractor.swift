//
//  ContactInteractor.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import AddressBookUI
class ContactInteractor: NSObject, ContactInteractorInput{
    var output:ContactInteractorOutput?
    var contactManager: ContactDataManager
    init(contactManager:ContactDataManager){
        self.contactManager = contactManager
    }
    

//    func fetchContacts(searchQuery:String?){
//        self.contactManager.fetchAllContacts(searchQuery ,completion: { [unowned self] people,error in
//            if (error == nil) {
//                if let _ = searchQuery {
//                    self.output?.showFilteredContacts(people)
//                }else{
//                    self.output?.showContacts(people)
//                }
//            }else{
//                self.output?.showError(error)
//            }
//        })
//    }
}
