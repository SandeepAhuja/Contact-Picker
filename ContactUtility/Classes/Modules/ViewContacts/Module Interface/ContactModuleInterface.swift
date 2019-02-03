//
//  ContactModuleInterface.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation

@objc protocol ContactModuleInterface {
    @objc optional func updateContacts()
    @objc optional func searchContacts(_ searchSting:String)
}
