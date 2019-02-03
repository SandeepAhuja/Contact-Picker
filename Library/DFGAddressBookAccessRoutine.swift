//
//  DFGAddressBookAccessRoutine.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 14/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import Contacts

class DFGAddressBookAccessRoutine: DFGAddressBookAccessBaseRoutine {
    override init(addressBook: DFGAddressBookWrapperRef) {
        super.init(addressBook: addressBook)
    }
    
    class func accessStatus() -> DFGAddressBookAccess {
        if #available (iOS 9.0,*){
            let authorizationStatus:CNAuthorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
            switch authorizationStatus{
            case .denied:
                return DFGAddressBookAccess.DFGAddressBookAccessDenied
            case .restricted:
                return DFGAddressBookAccess.DFGAddressBookAccessDenied
            case.authorized:
                return DFGAddressBookAccess.DFGAddressBookAccessGranted
            default:
                return DFGAddressBookAccess.DFGAddressBookAccessUnknown
            }
        }
        return DFGAddressBookAccess.DFGAddressBookAccessUnknown
    }
    
    func requestAccessWithCompletion(_ completionBlock: ((_ granted: Bool, _ error: Error?) -> Void)?) {
        if #available(iOS 9.0, *){
            let store = self.ref.addressBook as! CNContactStore
            store.requestAccess(for: .contacts, completionHandler: { (granted, err) in
                if completionBlock != nil {
                    completionBlock!(granted,err)
                }
            })
        }
    }


}
