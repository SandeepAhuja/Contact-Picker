//
//  SettingsPresenter.swift
//  ContactUtility
//
//  Created by Hitesh on 01/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class SettingsPresenter: NSObject,SettingsModuleInterface,SettingsInteractoreOuput {
    var settingsInteractor : SettingsInteractor?
    var settingsWireframe : SettingsWireFrame?
    var settingsModuleDelegate : SettingsModuleDelegate?
    var settingsViewController : SettingsInterface?
    
    func updateView(){
        let update:(searchBar:Bool,indexedSearch:Bool) =  (settingsInteractor?.readUserPreferences())!
        settingsViewController?.configureView(update.searchBar, indexedSearch: update.indexedSearch)
    }
    
    func enforceSettings(searchBar:Bool, indexedSearch:Bool){
        settingsModuleDelegate?.addRemoveSearchBar(searchBar)
        settingsModuleDelegate?.addRemoveIndexedSearch(indexedSearch)
    }
    
    func cancelSettingsInterface(){
        settingsWireframe?.dismissSettingsInterface()
    }
    func saveSettings(searchbar:Bool,indexedSearch:Bool){
        settingsInteractor?.saveSettingsState(searchbar, indexedSearch: indexedSearch)
        settingsWireframe?.dismissSettingsInterface()
        
    }

}
