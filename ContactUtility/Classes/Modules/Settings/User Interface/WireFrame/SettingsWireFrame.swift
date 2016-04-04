//
//  SettingsWireFrame.swift
//  ContactUtility
//
//  Created by Hitesh on 01/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class SettingsWireFrame: NSObject {
    var settingsPresenter: SettingsPresenter?
    var presentedViewController : UIViewController?
    
    func presentSettingsInterfaceFromViewController(viewController: UIViewController) {
        let newViewController = settingsViewController()
        let nav = UINavigationController(rootViewController: newViewController)
        newViewController.eventHandler = settingsPresenter
        newViewController.modalPresentationStyle = .FullScreen
        settingsPresenter?.configureUserInterfaceForPresentation(newViewController)
        viewController.presentViewController(nav, animated: true, completion: nil)
        presentedViewController = newViewController
    }
    
    func dismissSettingsInterface() {
        presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func settingsViewController() -> SettingsViewController {
        let storyboard = mainStoryboard()
        
        let settingsViewController: SettingsViewController = storyboard.instantiateViewControllerWithIdentifier(String(SettingsViewController.self)) as! SettingsViewController
        return settingsViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Settings", bundle: NSBundle.mainBundle())
        return storyboard
    }
}
