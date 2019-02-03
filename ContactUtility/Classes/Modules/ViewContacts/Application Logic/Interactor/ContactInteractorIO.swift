//
//  ContactInteractorIO.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation

@objc protocol ContactInteractorInput {
    @objc optional func fetchContacts(_ searchQuery:String?)
}

@objc protocol ContactInteractorOutput {
    
    @objc optional func showContacts(_ contacts:[AnyObject]?)
    @objc optional func showError(_ message: NSError?)
    @objc optional func showFilteredContacts(_ contacts:[AnyObject]?)
}

