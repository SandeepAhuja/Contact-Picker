//
//  DFGAddressBookBaseRoutine.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 14/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit

class DFGAddressBookAccessBaseRoutine: NSObject {
    var ref:DFGAddressBookWrapperRef
    init(addressBook:DFGAddressBookWrapperRef){
        self.ref = addressBook
    }
}
