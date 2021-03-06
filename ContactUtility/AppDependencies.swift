//
//  AppDependencies.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies: NSObject {
    var contactWireframe = ContactWireFrame()
    
    override init() {
        super.init()
        configureDependencies()
    }
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        contactWireframe.presentContactInterfaceFromWindow(window)
    }
    
    func configureDependencies() {
        let rootWireframe = RootWireFrame()
        let contactPresenter = ContactPresenter()
        let contactDataManager = ContactDataManager()
        let contactInteractor = ContactInteractor(contactManager: contactDataManager)
        contactInteractor.output = contactPresenter
        contactPresenter.contactInteractor = contactInteractor
        contactPresenter.contactWireFrame = contactWireframe
        contactWireframe.contactPresenter = contactPresenter
        contactWireframe.rootWireFrame = rootWireframe
    }

}
