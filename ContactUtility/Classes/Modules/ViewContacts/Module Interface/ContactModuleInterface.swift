//
//  ContactModuleInterface.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation

@objc protocol ContactModuleInterface {
    optional func updateContacts()
    optional func searchContacts(searchSting:String)
}