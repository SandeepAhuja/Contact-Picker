//
//  BaseViewController.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 12/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit

public class BaseViewController: UITableViewController {
    var selectedContacts:[String] = [String]()
    static let cellIdentifier = "cell"
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier:BaseViewController.cellIdentifier)
    }

    func manageSelectedContacts(selectedItem:ContactDisplayItem){
        if selectedContacts.contains(selectedItem.identifier!) {
            if  let index:Int = selectedContacts.indexOf(selectedItem.identifier!) where index != NSIntegerMax{
                selectedContacts.removeAtIndex(index)
            }
        }else{
            selectedContacts.append(selectedItem.identifier!)
        }
    }

    
    func configureCell(cell:UITableViewCell, upcomingItem:ContactDisplayItem){
        if self.selectedContacts.contains(upcomingItem.identifier!) {
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }


        upcomingItem.name?.fullName = self.contactName(upcomingItem)
        cell.textLabel?.text = upcomingItem.name?.fullName
        
        var finalimage:UIImage?
        if let image = upcomingItem.thumbnailImage {
            finalimage = image
        }else{
            finalimage = UIImage(named: "contactplaceholder")
        }
        finalimage = finalimage?.makeThumbnailOfSize(CGSizeMake(30, 30))
        cell.imageView?.image = finalimage
        cell.imageView?.contentMode = .ScaleAspectFill
        
        let layer:CALayer = (cell.imageView?.layer)!
        layer.cornerRadius = 15
        layer.masksToBounds = true
        cell.imageView?.clipsToBounds = true
    }
    
    func contactName(contact :ContactDisplayItem) -> String? {
        if let firstName = contact.name?.firstName, lastName = contact.name?.lastName {
            return "\(firstName) \(lastName)"
        }
        else if let firstName = contact.name?.firstName {
            return "\(firstName)"
        }
        else if let lastName = contact.name?.lastName {
            return "\(lastName)"
        }
        else if contact.phones?.count > 0{
            for phone in contact.phones!{
                return phone.number as String!
            }
        }
        return "No Name"
    }


}
