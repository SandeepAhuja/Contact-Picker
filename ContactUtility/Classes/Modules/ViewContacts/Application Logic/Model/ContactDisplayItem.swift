//
//  ContactDisplayItem.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
import UIKit
import AddressBook
class ContactDisplayItem: NSObject {
    var identifier:String?
    var phones:[ContactPhone]?
    var isSelected:Bool = false
    var thumbnailImage:UIImage?
    var name:ContactName?
}
