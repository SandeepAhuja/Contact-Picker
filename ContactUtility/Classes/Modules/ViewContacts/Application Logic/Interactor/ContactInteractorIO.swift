//
//  ContactInteractorIO.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation

@objc protocol ContactInteractorInput {
    optional func fetchContacts(searchQuery:String?)
}

@objc protocol ContactInteractorOutput {
    
    optional func showContacts(contacts:[AnyObject]?)
    optional func showError(message: NSError?)
    optional func showFilteredContacts(contacts:[AnyObject]?)
}

