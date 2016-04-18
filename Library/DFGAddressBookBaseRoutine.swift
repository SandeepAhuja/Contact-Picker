//
//  DFGAddressBookBaseRoutine.swift
//  ContactUtility
//
//  Created by Hitesh on 14/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class DFGAddressBookAccessBaseRoutine: NSObject {
    var ref:DFGAddressBookWrapperRef
    init(addressBook:DFGAddressBookWrapperRef){
        self.ref = addressBook
    }
}
