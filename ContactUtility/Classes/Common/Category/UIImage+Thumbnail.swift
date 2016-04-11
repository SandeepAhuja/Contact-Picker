//
//  UIImage+Thumbnail.swift
//  ContactUtility
//
//  Created by Hitesh on 11/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func makeThumbnailOfSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.mainScreen().scale)
        // draw scaled image into thumbnail context
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newThumbnail: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        // pop the context
        UIGraphicsEndImageContext()
        if newThumbnail == nil {
            NSLog("could not scale image")
        }
        return newThumbnail!
    }
}