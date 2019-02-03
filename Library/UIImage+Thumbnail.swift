//
//  UIImage+Thumbnail.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 11/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func makeThumbnailOfSize(_ size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        // draw scaled image into thumbnail context
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newThumbnail: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        // pop the context
        UIGraphicsEndImageContext()
        if newThumbnail == nil {
            print("could not scale image")
        }
        return newThumbnail!
    }
}
