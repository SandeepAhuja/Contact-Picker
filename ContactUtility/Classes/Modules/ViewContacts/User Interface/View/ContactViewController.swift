//
//  ContactViewController.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import QuartzCore


class ContactViewController: BaseViewController {
    
    // MARK: Properties
    var eventHandler : ContactModuleInterface?
    var dataProperty : ContactDisplayData?
    var sectionIndexes :[String]?
    var searchController : UISearchController!
    var resultController : ResultViewController!
    var strongTableView:UITableView?
    var allowMultipleSelection : Bool?
    var searchBarVisible : Bool?
    var indexedSearchVisible :Bool?
    @IBOutlet var noContentView : UIView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        eventHandler?.updateContacts()
    }
    
    // MARK: Selector
    func configureView() {
        strongTableView = self.tableView
        self.tableView.allowsMultipleSelection = true
        eventHandler?.updateUI()
//        self.edgesForExtendedLayout = .None
//        self.extendedLayoutIncludesOpaqueBars = false
//        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "Contacts"
        let settingsItem = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action: Selector("showSettings"))
        navigationItem.rightBarButtonItem = settingsItem
        
    }
    func showSettings(){
        eventHandler?.presentSettingsInterface()
    }
    
    // MARK: TableView Delegate and Datasource
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
        let cell = tableView.dequeueReusableCellWithIdentifier(BaseViewController.cellIdentifier, forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, upcomingItem: upcomingItem)
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let upcomingSection = dataProperty?.sections![indexPath.section]
        let upcomingItem:ContactDisplayItem = upcomingSection!.items[indexPath.row]
        upcomingItem.isSelected = !upcomingItem.isSelected
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        
    }
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]?{
        return sectionIndexes
    }
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int{
        if let indexFound = dataProperty?.allKeys?.indexOf(title) {
            return indexFound
        }
        return index
    }
    
}

// MARK: ContactViewInterface
extension ContactViewController : ContactViewInterface {
    func updateFilteredContacts(data:[ContactDisplayItem]){
        let resultsController = searchController.searchResultsController as! ResultViewController
        resultsController.filteredProducts = data
        resultsController.tableView.reloadData()
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
        self.tableView?.reloadData()
    }
    
    func addRemoveSearchbar(flag:Bool){
        if flag{
            if self.searchController == nil {
                self.resultController = ResultViewController()
                
                self.resultController!.tableView.delegate = self

                self.searchController = UISearchController(searchResultsController: resultController)
                self.searchController.hidesNavigationBarDuringPresentation = true
                self.searchController.searchResultsUpdater = self
                self.searchController.searchBar.sizeToFit()
                tableView.tableHeaderView = searchController.searchBar
                
                self.searchController.dimsBackgroundDuringPresentation = false // default is YES
                self.searchController.searchBar.delegate = self    // so we can monitor text changes + others
                
                definesPresentationContext = true
            }
        }else{
            if self.searchController != nil {
                self.searchController?.searchBar.delegate = nil
                self.resultController = nil
                strongTableView?.tableHeaderView = nil
                self.searchController?.searchBar.removeFromSuperview()
                self.searchController = nil
            }
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

}

// MARK: SearchBar Delegate and Results Update
extension ContactViewController : UISearchResultsUpdating,UISearchBarDelegate {
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let whitespaceCharacterSet = NSCharacterSet.whitespaceCharacterSet()
        let strippedString = searchController.searchBar.text!.stringByTrimmingCharactersInSet(whitespaceCharacterSet)
        eventHandler?.searchContacts(strippedString)
    }
}



