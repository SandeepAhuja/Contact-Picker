//
//  AppDelegate.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 28/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    let appDependencies = AppDependencies()
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool{
        appDependencies.installRootViewControllerIntoWindow(window!)
        
        return true
    }
}

