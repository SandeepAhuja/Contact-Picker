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

    
    func presentContactInterfaceFromWindow(window: UIWindow) {
        let viewController = ContactViewController()
        viewController.eventHandler = contactPresenter
        contactViewController = viewController
        contactPresenter!.userInterface = viewController
        rootWireFrame?.showRootViewController(viewController, inWindow: window)
    }
    
    func presentAlertContoller(message:NSError?) {
        let alert = UIAlertController(title: .None, message: message?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
        contactViewController?.presentViewController(alert, animated: true, completion: nil)                
    }
    
}
