//
//  AppDependencies.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies: NSObject {
    var contactWireframe = ContactWireFrame()
    
    override init() {
        super.init()
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        contactWireframe.presentContactInterfaceFromWindow(window)
    }
    
    func configureDependencies() {
        let rootWireframe = RootWireFrame()
        
        let settingsDataManager = SettingsDataManager()

        let addSearchBarPresenter = SearchBarPresenter()
        
        let addSearchBarWireFrame = AddSearchBarWireFrame()
        addSearchBarWireFrame.presenter = addSearchBarPresenter
        
        addSearchBarPresenter.wireFrame = addSearchBarWireFrame

        let addSearchBarDataManager = SearchDataManager()
        
        let addSerchBarInteractor = SearchBarInteractor(presenter: addSearchBarPresenter, dataManager: addSearchBarDataManager)
        addSearchBarPresenter.interactor = addSerchBarInteractor
        addSerchBarInteractor.settingManager = settingsDataManager
        
        
        let contactPresenter = ContactPresenter()
        let contactDataManager = ContactDataManager()

        let contactInteractor = ContactInteractor(contactManager: contactDataManager)
        let settingsInteractor = SettingsInteractor()
        settingsInteractor.dataManager = settingsDataManager
        let settingsWireFrame = SettingsWireFrame()
        let settingsPresenter = SettingsPresenter()
        settingsInteractor.output = settingsPresenter
        settingsPresenter.settingsModuleDelegate = contactPresenter
        settingsWireFrame.settingsPresenter = settingsPresenter
        settingsPresenter.settingsInteractor = settingsInteractor
        settingsPresenter.settingsWireframe = settingsWireFrame

        contactInteractor.output = contactPresenter
        contactPresenter.contactInteractor = contactInteractor
        contactPresenter.contactWireFrame = contactWireframe
        contactWireframe.addSearchBarWireFrame = addSearchBarWireFrame
        contactWireframe.contactPresenter = contactPresenter
        contactWireframe.settingsWireFrame = settingsWireFrame
        contactWireframe.rootWireFrame = rootWireframe
    }

}
