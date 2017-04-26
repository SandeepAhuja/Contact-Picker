//
//  ContactViewInterface.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation

protocol ContactViewInterface {
    func showNoContentMessage()
    func showFetchedContactsData(data:ContactDisplayData!)
    func updateFilteredContacts(data:[ContactDisplayItem])
    func reloadEntries ()
}