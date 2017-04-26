//
//  DFGAddressBookAccessRoutine.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 14/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import AddressBook
import Contacts

class DFGAddressBookAccessRoutine: DFGAddressBookAccessBaseRoutine {
    override init(addressBook: DFGAddressBookWrapperRef) {
        super.init(addressBook: addressBook)
    }
    
    class func accessStatus() -> DFGAddressBookAccess {
        if #available (iOS 9.0,*){
            let authorizationStatus:CNAuthorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
            switch authorizationStatus{
            case .Denied:
                return DFGAddressBookAccess.DFGAddressBookAccessDenied
            case .Restricted:
                return DFGAddressBookAccess.DFGAddressBookAccessDenied
            case.Authorized:
                return DFGAddressBookAccess.DFGAddressBookAccessGranted
            default:
                return DFGAddressBookAccess.DFGAddressBookAccessUnknown
            }
        }else{
            let status: ABAuthorizationStatus = ABAddressBookGetAuthorizationStatus()
            switch status {
            case .Denied:
                return DFGAddressBookAccess.DFGAddressBookAccessDenied
            case .Restricted:
                return DFGAddressBookAccess.DFGAddressBookAccessDenied
            case .Authorized:
                return DFGAddressBookAccess.DFGAddressBookAccessGranted
            default:
                return DFGAddressBookAccess.DFGAddressBookAccessUnknown
            }
        }
    }
    
    func requestAccessWithCompletion(completionBlock: ((granted: Bool, error: NSError?) -> Void)?) {
        if #available(iOS 9.0, *){
            let store = self.ref.addressBook as! CNContactStore
            store.requestAccessForEntityType(CNEntityType.Contacts){ (granted: Bool, err: NSError?) in
                if completionBlock != nil {
                    completionBlock!(granted: granted, error: err)
                }
            }
        }else{
            if self.ref.errorRef == nil {
                ABAddressBookRequestAccessWithCompletion(self.ref.addressBook) { granted, error in
                    if completionBlock != nil && granted {
                        completionBlock!(granted: granted, error: nil)
                    }else{
                        completionBlock!(granted: false, error: error as NSError)
                    }
                }
            }else {
                if completionBlock != nil {
                    completionBlock!(granted: false, error: self.ref.errorRef!)
                }
                
            }
        }
    }


}
