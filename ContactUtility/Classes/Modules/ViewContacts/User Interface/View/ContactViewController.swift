//
//  ContactViewController.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

let kContactCellIdentifier = "cell"

class ContactViewController: UITableViewController,ContactViewInterface {
    var eventHandler: ContactModuleInterface?
    var dataProperty:ContactDisplayData?
    var strongTableView : UITableView?
    @IBOutlet var noContentView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        strongTableView = tableView
        configureView()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        eventHandler?.updateView()
    }
    func configureView() {
        navigationItem.title = "Contacts"
        strongTableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier:kContactCellIdentifier)
        let settingsItem = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: Selector("showSettings"))
        navigationItem.rightBarButtonItem = settingsItem
        
    }
    func showSettings(){
        eventHandler?.presentSettingsInterface()
    }
    
    func showFetchedContactsData(data:ContactDisplayData!){
        view = strongTableView
        dataProperty = data
        reloadEntries()
    }
    
    func showNoContentMessage() {
        view = noContentView
    }
    
    func reloadEntries() {
        tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numberOfSections = dataProperty?.sections!.count
        
        if dataProperty?.sections!.count == nil {
            numberOfSections = 0
        }
        
        return numberOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let upcomingSection = dataProperty?.sections![section]
        return upcomingSection!.items.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let upcomingSection = dataProperty?.sections![section]
        return upcomingSection!.name
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let upcomingSection = dataProperty?.sections![indexPath.section]
        let upcomingItem = upcomingSection!.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kContactCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = upcomingItem.fullName
        return cell
    }

}
