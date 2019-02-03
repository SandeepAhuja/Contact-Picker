//
//  SelectedContactsTableViewController.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 18/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit

class SelectedContactsTableViewController: BaseViewController {
    var allContacts:[String] = [String]()
    var contacts : [ContactDisplayItem] = [ContactDisplayItem]()
    let addressBook:DFGAddressBook = DFGAddressBook()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchContactsFromAddressBook()
        
    }
    
    func fetchContactsFromAddressBook(){
        for identifier in allContacts{
                addressBook.loadContactByRecordID(identifier, completion: {[unowned self] (contactDisplayItem, error) -> Void in
                    if let contact = contactDisplayItem, error == nil{
                        self.contacts.append(contact)
                    }
                    
                })
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseViewController.cellIdentifier)!
        
        let upcomingItem = contacts[indexPath.row]
        self.configureCell(cell, upcomingItem: upcomingItem)
        return cell
    }
        
}
