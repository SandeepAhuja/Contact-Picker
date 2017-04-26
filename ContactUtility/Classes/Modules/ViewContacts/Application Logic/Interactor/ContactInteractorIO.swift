//
//  ContactInteractorIO.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
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

