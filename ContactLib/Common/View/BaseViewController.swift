//
//  BaseViewController.swift
//  ContactUtility
//
//  Created by Hitesh on 12/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    static let cellIdentifier = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier:BaseViewController.cellIdentifier)
    }

   
    
    func configureCell(cell:UITableViewCell, upcomingItem:ContactDisplayItem){
        if upcomingItem.isSelected == true{
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
        cell.textLabel?.text = self.contactName(upcomingItem)
        
        
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