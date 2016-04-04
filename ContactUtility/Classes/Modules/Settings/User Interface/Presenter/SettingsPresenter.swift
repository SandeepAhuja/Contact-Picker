//
//  SettingsPresenter.swift
//  ContactUtility
//
//  Created by Hitesh on 01/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class SettingsPresenter: NSObject,SettingsModuleInterface {
    var settingsInteractor : SettingsInteractor?
    var settingsWireframe : SettingsWireFrame?

    func updateView() {
        
    }
    func cancelSettingsInterface(){
        settingsWireframe?.dismissSettingsInterface()
    }
    func saveSettings(searchbar:Bool,indexedSearch:Bool){
        settingsWireframe?.dismissSettingsInterface()
    }

    
    func configureUserInterfaceForPresentation(settingsInterface: SettingsInterface) {
        settingsInterface.configureView()
    }

}
