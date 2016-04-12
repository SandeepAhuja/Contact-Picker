//
//  AppDelegate.swift
//  ContactUtility
//
//  Created by Hitesh on 28/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    let appDependencies = AppDependencies()
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool{
        appDependencies.installRootViewControllerIntoWindow(window!)
        
        return true
    }
}

