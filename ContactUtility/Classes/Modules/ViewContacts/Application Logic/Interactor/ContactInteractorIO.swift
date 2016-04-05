//
//  ContactInteractorIO.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation

protocol ContactInteractorInput {
    func fetchContacts()
    func configureUI()
}

protocol ContactInteractorOutput {
    func showContacts(contacts:ContactDisplayData?)
    func showError(message: NSError?)
    func addRemoveSearchBar(flag:Bool)    
    func showIndexedSearch(flag:Bool)
}

