//
//  ContactWireFrame.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
import UIKit

class ContactWireFrame: NSObject {
    var contactPresenter: ContactPresenter?
    var rootWireFrame : RootWireFrame?
    var contactViewController: ContactViewController?
    var settingsWireFrame: SettingsWireFrame?
    var localSearchBar:UISearchBar?

    func presentSettings() {
        settingsWireFrame?.presentSettingsInterfaceFromViewController(contactViewController!)
    }
    
    func presentContactInterfaceFromWindow(window: UIWindow) {
        let viewController = ContactViewController()
        viewController.eventHandler = contactPresenter
        contactViewController = viewController
        contactPresenter?.userInterface = viewController
        rootWireFrame?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentAlertContoller(message:NSError?) {
        let alert = UIAlertController(title: .None, message: message?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        contactViewController?.presentViewController(alert, animated: true, completion: nil)                
    }
    
    
    func addSearchBarOnViewController(){
        if self.localSearchBar == nil {
            let view = contactViewController?.view
            let searchBar = UISearchBar()
            searchBar.showsCancelButton = true
            searchBar.delegate = contactPresenter
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            self.localSearchBar = searchBar
            view?.addSubview(localSearchBar!)
            
            let viewDict:[String:UIView] = ["searchbar":self.localSearchBar!,"view":view!]
            
            let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[searchbar(==view)]|", options:[], metrics: .None, views: viewDict)
            let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[searchbar(==44)]", options: [], metrics: .None, views: viewDict)
            view?.addConstraints(horizontalConstraint)
            view?.addConstraints(verticalConstraint)
            view?.layoutIfNeeded()
            contactViewController?.addRemoveSearchbar(true)
        }
    }
    
    func removeSearchBar(){
        if self.localSearchBar != nil {
            localSearchBar?.delegate = nil
            localSearchBar?.removeFromSuperview()
            localSearchBar = nil
            contactViewController!.addRemoveSearchbar(false)
            
        }
    }

    
}
