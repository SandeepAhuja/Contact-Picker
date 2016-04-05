//
//  ContactViewController.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

let kContactCellIdentifier = "cell"

class ContactViewController: UIViewController,ContactViewInterface,UITableViewDelegate,UITableViewDataSource,SearchModuleDelegate {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    var eventHandler: ContactModuleInterface?
    var dataProperty:ContactDisplayData?
    var filteredData:ContactDisplayData?
    
    var localSearchBar:UISearchBar?
    @IBOutlet var tableView : UITableView!
    @IBOutlet var noContentView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        eventHandler?.updateContacts()

    }
    func configureView() {
        eventHandler?.updateUI()
        self.edgesForExtendedLayout = .None
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "Contacts"
        tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier:kContactCellIdentifier)
        let settingsItem = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: Selector("showSettings"))
        navigationItem.rightBarButtonItem = settingsItem
        
    }
    func showSettings(){
        eventHandler?.presentSettingsInterface()
    }
    
    func showFetchedContactsData(data:ContactDisplayData!){        
        dataProperty = data
        reloadEntries()
    }
    
    func showNoContentMessage() {
    //    view = noContentView
    }
    
    func reloadEntries() {
        tableView?.reloadData()

    }
    
    func addRemoveSearchbar(flag:Bool){
        if flag{
            topConstraint.constant = 44.0
        }else{
            topConstraint.constant = 0
        }
        
    }
    func parentView()-> UIView!{
        return view
    }

    func addRemoveIndexedSearch(flag:Bool){
        if flag {
            
        }else{
            
        }

    }


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numberOfSections = dataProperty?.sections!.count
        
        if dataProperty?.sections!.count == nil {
            numberOfSections = 0
        }
        
        return numberOfSections!
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let upcomingSection = dataProperty?.sections![section]
        return upcomingSection!.items.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let upcomingSection = dataProperty?.sections![section]
        return upcomingSection!.name
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let upcomingSection = dataProperty?.sections![indexPath.section]
        let upcomingItem = upcomingSection!.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kContactCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = upcomingItem.fullName
        return cell
    }

}
