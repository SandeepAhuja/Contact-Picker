//
//  ContactViewInterface.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation

protocol ContactViewInterface {
    func showNoContentMessage()
    func showFetchedContactsData(data:ContactDisplayData!)
    func reloadEntries ()
}