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
    var contactSettingsManager: SettingsDataManager
    init(contactManager:ContactDataManager, settingsManager: SettingsDataManager){
        self.contactManager = contactManager
        self.contactSettingsManager = settingsManager
    }

    func configureUI(){
        let update =  self.contactSettingsManager.getUserPreferences()
        self.output?.showSearchBar(update.searchBar)
        self.output?.showIndexedSearch(update.indexedSearch)
    }

    
    func fetchContacts(){
        self.contactManager.fetchAllContacts(nil ,completion: { [unowned self] people,error in
            if (error == nil) {
                self.output?.showContacts(people)
            }else{
                self.output?.showError(error)
            }
        })
    }
}
