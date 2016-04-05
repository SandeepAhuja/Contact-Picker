//
//  SearchBarInteractor.swift
//  ContactUtility
//
//  Created by Hitesh on 01/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class SearchBarInteractor: NSObject,AddSearchBarInteractorInput {
    var output:AddSearchBarInteractorOutput
    var dataManager: SearchDataManager
    var settingManager : SettingsDataManager?
    init(presenter:AddSearchBarInteractorOutput, dataManager: SearchDataManager){
        self.dataManager = dataManager
        self.output = presenter
    }
    
    func updateUI(){
        let update =  self.settingManager!.getUserPreferences()
        self.output.showSearchBar(update.searchBar)
    }
}
