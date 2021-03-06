//
//  BaseViewController.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 12/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


open class BaseViewController: UITableViewController {
    var selectedContacts:[String] = [String]()
    static let cellIdentifier = "cell"
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier:BaseViewController.cellIdentifier)
    }

    func manageSelectedContacts(_ selectedItem:ContactDisplayItem){
        if selectedContacts.contains(selectedItem.identifier!) {
            if  let index:Int = selectedContacts.index(of: selectedItem.identifier!), index != NSIntegerMax{
                selectedContacts.remove(at: index)
            }
        }else{
            selectedContacts.append(selectedItem.identifier!)
        }
    }

    
    func configureCell(_ cell:UITableViewCell, upcomingItem:ContactDisplayItem){
        if self.selectedContacts.contains(upcomingItem.identifier!) {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }


        upcomingItem.name?.fullName = self.contactName(upcomingItem)
        cell.textLabel?.text = upcomingItem.name?.fullName
        
        var finalimage:UIImage?
        if let image = upcomingItem.thumbnailImage {
            finalimage = image
        }else{
            finalimage = UIImage(named: "contactplaceholder")
        }
        finalimage = finalimage?.makeThumbnailOfSize(CGSize(width: 30, height: 30))
        cell.imageView?.image = finalimage
        cell.imageView?.contentMode = .scaleAspectFill
        
        let layer:CALayer = (cell.imageView?.layer)!
        layer.cornerRadius = 15
        layer.masksToBounds = true
        cell.imageView?.clipsToBounds = true
    }
    
    func contactName(_ contact :ContactDisplayItem) -> String? {
        if let firstName = contact.name?.firstName, let lastName = contact.name?.lastName {
            return "\(firstName) \(lastName)"
        }
        else if let firstName = contact.name?.firstName {
            return "\(firstName)"
        }
        else if let lastName = contact.name?.lastName {
            return "\(lastName)"
        }
        else if contact.phones?.count > 0{
            for phone in (contact.phones)! {
                return phone.number
            }
        }
        return "No Name"
    }


}
