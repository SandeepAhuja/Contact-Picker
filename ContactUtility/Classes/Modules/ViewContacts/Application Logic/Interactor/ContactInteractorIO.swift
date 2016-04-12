//
//  ContactInteractorIO.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation

protocol ContactInteractorInput {
    func fetchContacts(searchQuery:String?)
    func configureUI()
}

protocol ContactInteractorOutput {
    func showContacts(contacts:[AnyObject]?)
    func showError(message: NSError?)
    func addRemoveSearchBar(flag:Bool)    
    func addRemoveIndexedSearch(flag:Bool)
    func showFilteredContacts(contacts:[AnyObject]?)
}

