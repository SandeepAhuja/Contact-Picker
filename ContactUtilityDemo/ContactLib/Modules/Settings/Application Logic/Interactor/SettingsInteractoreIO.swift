//
//  SettingsInteractoreIO.swift
//  ContactUtility
//
//  Created by Hitesh on 04/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation

protocol SettingsInteractoreInput {
    func saveSettingsState(searchBar:Bool, indexedSearch:Bool)
}

protocol SettingsInteractoreOuput {
    func enforceSettings(searchBar:Bool, indexedSearch:Bool)
}


