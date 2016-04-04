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
    var settingsModuleDelegate: SettingsModuleDelegate?
    func updateView() {
        
    }
    
    func enforceSettings(searchBar:Bool, indexedSearch:Bool){
        settingsModuleDelegate?.settingsModuleDidSaveChanges()
    }
    
    func cancelSettingsInterface(){
        settingsWireframe?.dismissSettingsInterface()
    }
    func saveSettings(searchbar:Bool,indexedSearch:Bool){
        settingsInteractor?.saveSettingsState(searchbar, indexedSearch: indexedSearch)
        settingsWireframe?.dismissSettingsInterface()
        
    }

    
    func configureUserInterfaceForPresentation(settingsInterface: SettingsInterface) {
        settingsInterface.configureView()
    }

}
