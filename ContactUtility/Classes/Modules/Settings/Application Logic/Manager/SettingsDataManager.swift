//
//  SettingsDataManager.swift
//  ContactUtility
//
//  Created by Hitesh on 01/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

let kSearchbarKey = "searchbar"
let kIndexedSearchkey = "indexedSearch"

class SettingsDataManager: NSObject {
    func saveSettingsState(searchBar:Bool, indexedSearch:Bool){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setBool(searchBar, forKey: kSearchbarKey)
        userDefaults.setBool(searchBar, forKey: kIndexedSearchkey)
        userDefaults.synchronize()
    }
    
    func getUserPreferences()->(searchBar:Bool, indexedSearch:Bool){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let isSearchBarOn = userDefaults.boolForKey(kSearchbarKey)
        let isIndexedSearchOn = userDefaults.boolForKey(kIndexedSearchkey)
        return (isSearchBarOn,isIndexedSearchOn)
    }

}
