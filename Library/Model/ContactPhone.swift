//
//  ContactPhone.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 08/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit

class ContactPhone: NSObject,NSCopying{
    required override init() { // <== Need "required" because we need to call dynamicType() below

    }
    func copyWithZone(zone: NSZone) -> AnyObject { // <== NSCopying
        // *** Construct "one of my current class". This is why init() is a required initializer
        let theCopy = self.dynamicType.init()
        theCopy.number = self.number
        theCopy.originalLabel = self.originalLabel
        theCopy.localizedLabel = self.localizedLabel
        return theCopy
    }
    var number: String?
    var originalLabel: String?
    var localizedLabel: String?
}
