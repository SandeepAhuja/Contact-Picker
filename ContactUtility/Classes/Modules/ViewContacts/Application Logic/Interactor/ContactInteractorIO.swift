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
}

protocol ContactInteractorOutput {
    func showContacts(contacts:[AnyObject]?)
    func showError(message: NSError?)
    func showFilteredContacts(contacts:[AnyObject]?)
}

