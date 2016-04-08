//
//  ImageExtractor.swift
//  ContactUtility
//
//  Created by Hitesh on 08/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
import UIKit
import AddressBook
import Contacts

class ImageExtractor: NSObject {
    
    class func thumbnailWithRecordRef(recordRef:AnyObject)->UIImage?{
        if #available(iOS 9.0, *) {
            return imageWithCNContact(recordRef as! CNContact, fullSize: false)
        }else{
            return imageWithRecordRef(recordRef, fullsize: false)
        }
    }
    
    class func photoWithRecordRef(recordRef:ABRecordRef)->UIImage?{
        if #available(iOS 9.0, *) {
            return imageWithCNContact(recordRef as! CNContact, fullSize: true)
        }else{
            return imageWithRecordRef(recordRef, fullsize: true)
        }
    }
    
    @available(iOS 9.0, *)
    private class func imageWithCNContact(contact:CNContact,fullSize:Bool?)->UIImage?{
        if (contact.isKeyAvailable(CNContactThumbnailImageDataKey)){
            if let imgData = contact.thumbnailImageData{
                return UIImage(data: imgData, scale: UIScreen.mainScreen().scale)
            }
        }
        
        return nil
    }
    
    private class func imageWithRecordRef(recordRef:ABRecordRef,fullsize:Bool?)->UIImage?{
        let format:ABPersonImageFormat = fullsize! ? kABPersonImageFormatOriginalSize :
        kABPersonImageFormatThumbnail
        if let data:NSData = ABPersonCopyImageDataWithFormat(recordRef, format).takeRetainedValue(){
            return UIImage(data: data, scale: UIScreen.mainScreen().scale)
        }
        return nil
        
    }

}
