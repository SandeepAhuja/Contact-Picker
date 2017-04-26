//
//  ContactDisplayItem.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation
import UIKit
import AddressBook
class ContactDisplayItem: NSObject {
    var identifier:String?
    var phones:[ContactPhone]?
    var thumbnailImage:UIImage?
    var name:ContactName?
}
