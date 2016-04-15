//
//  DFGAddressBookBaseRoutine.swift
//  ContactUtility
//
//  Created by Hitesh on 14/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class DFGAddressBookAccessBaseRoutine: NSObject {
    var ref:AddressBookWrapperRef
    init(addressBook:AddressBookWrapperRef){
        self.ref = addressBook
    }
}
