//
//  ContactViewController.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import QuartzCore
let kContactCellIdentifier = "cell"

class ContactViewController: UIViewController,ContactViewInterface,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    var eventHandler: ContactModuleInterface?
    var dataProperty:ContactDisplayData?
    var filteredData:ContactDisplayData?
    var sectionIndexes:[String]?
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
        tableView.allowsMultipleSelection = true
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

    func addRemoveIndexedSearch(flag:Bool){
        if flag {
            sectionIndexes = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z","#"]
        }else{
            sectionIndexes?.removeAll()
        }
        self.reloadEntries()
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
        if upcomingItem.isSelected == true{
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
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
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let upcomingSection = dataProperty?.sections![indexPath.section]
        let upcomingItem:ContactDisplayItem = upcomingSection!.items[indexPath.row]
        upcomingItem.isSelected = !upcomingItem.isSelected
    
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        
    }
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]?{
        return sectionIndexes
    }
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int{
        if let indexFound = dataProperty?.allKeys?.indexOf(title) {
            return indexFound
        }
        return index
    }
}
