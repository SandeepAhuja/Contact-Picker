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
    func copy(with zone: NSZone?) -> Any { // <== NSCopying
        // *** Construct "one of my current class". This is why init() is a required initializer
        let theCopy = type(of: self).init()
        theCopy.number = self.number
        theCopy.originalLabel = self.originalLabel
        theCopy.localizedLabel = self.localizedLabel
        return theCopy
    }
    var number: String?
    var originalLabel: String?
    var localizedLabel: String?
}
