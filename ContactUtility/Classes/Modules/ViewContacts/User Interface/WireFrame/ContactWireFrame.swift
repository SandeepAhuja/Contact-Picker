//
//  ContactWireFrame.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation
import UIKit

class ContactWireFrame: NSObject {
    var contactPresenter: ContactPresenter?
    var rootWireFrame : RootWireFrame?
    var contactViewController: ContactViewController?
    
     
    func presentContactInterfaceFromWindow(_ window: UIWindow) {
        let viewController = ContactViewController(nibName: "ContactViewController", bundle: nil)
        viewController.searchBarVisible = true
        viewController.indexedSearchVisible = true
        viewController.allowMultipleSelection = true
        contactViewController = viewController
        contactPresenter?.userInterface = viewController
        rootWireFrame?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentAlertContoller(_ message:NSError?) {
        let alert = UIAlertController(title: .none, message: message?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        contactViewController?.present(alert, animated: true, completion: nil)                
    }
    
    
    func addSearchBarOnViewController(){
        contactViewController?.addRemoveSearchbar(true)      
    }
    
    func removeSearchBar(){
        contactViewController!.addRemoveSearchbar(false)
    }

    
}
