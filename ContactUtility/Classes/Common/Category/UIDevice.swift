//
//  UIDevice.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

public extension UIDevice {
    func deviceOperatingSystemVersion(){
        let os = NSProcessInfo().operatingSystemVersion
        switch (os.majorVersion, os.minorVersion, os.patchVersion) {
        case (8, 0, _):
            print("iOS >= 8.0.0, < 8.1.0")
        case (8, _, _):
            print("iOS >= 8.1.0, < 9.0")
        case (9, _, _):
            print("iOS >= 9.0.0")
        default:
            // this code will have already crashed on iOS 7, so >= iOS 10.0
            print("iOS >= 10.0.0")
        }
    }
}