//
//  SettingsInteractor.swift
//  ContactUtility
//
//  Created by Hitesh on 01/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class SettingsInteractor: NSObject,SettingsInteractoreInput {
    var output:SettingsInteractoreOuput?
    var dataManager:SettingsDataManager?
    func saveSettingsState(searchBar:Bool, indexedSearch:Bool) {
        dataManager?.saveSettingsState(searchBar, indexedSearch: indexedSearch)
        output?.enforceSettings(searchBar, indexedSearch: indexedSearch)
    }
    func readUserPreferences()->(searchBar:Bool, indexedSearch:Bool){
        return (dataManager?.getUserPreferences())!
    }
}
