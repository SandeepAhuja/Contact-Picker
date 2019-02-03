//
//  DFGImageExtractor.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 15/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import Foundation
import UIKit
import Contacts

class DFGImageExtractor: NSObject {
    class func thumbnailWithRecordRef(_ recordRef:CNContact)->UIImage?{
        return imageWithCNContact(recordRef, fullSize: false)
    }
    
    class func photoWithRecordRef(_ recordRef:CNContact)->UIImage?{
        return imageWithCNContact(recordRef, fullSize: true)
    }
    
    @available(iOS 9.0, *)
    fileprivate class func imageWithCNContact(_ contact:CNContact,fullSize:Bool?)->UIImage?{
        if fullSize == true {
            if (contact.isKeyAvailable(CNContactImageDataKey)){
                if let imgData = contact.imageData{
                    return UIImage(data: imgData, scale: UIScreen.main.scale)
                }
            }
        }else {
            if (contact.isKeyAvailable(CNContactThumbnailImageDataKey)){
                if let imgData = contact.thumbnailImageData{
                    return UIImage(data: imgData, scale: UIScreen.main.scale)
                }
            }
        }
        return nil
    }
    
}

