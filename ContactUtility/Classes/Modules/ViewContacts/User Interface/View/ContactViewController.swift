//
//  ContactViewController.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import QuartzCore


class ContactViewController: BaseViewController {
    
    // MARK: Properties
    let addressBook = DFGAddressBook()
    var dataProperty : ContactDisplayData?
    var allContacts : [ContactDisplayItem]?
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
        self.configureDependencies()
        self.configureView()
        self.loadContacts()
    }

    // MARK: Selector
    func configureDependencies(){
        self.addressBook.fieldsMask = DFGContactFields.DFGContactFieldDefault
        self.addressBook.sortDescriptors = [NSSortDescriptor(key: "name.firstName", ascending: true),
            NSSortDescriptor(key: "name.lastName", ascending: true)]
        
        self.addressBook.filterBlock = {
            (contact: ContactDisplayItem) -> Bool in
            if let phones = contact.phones {
                return phones.count > 0
            }
            return false
        }
    }
    
    func configureView() {
        strongTableView = self.tableView
        self.tableView.allowsMultipleSelection = self.allowMultipleSelection != nil ? self.allowMultipleSelection! : false
        self.addRemoveSearchbar(self.searchBarVisible != nil ? self.searchBarVisible! : false)
        self.addRemoveIndexedSearch(self.indexedSearchVisible != nil ? self.indexedSearchVisible! : false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:#selector(doneButtonPressed))
        self.navigationItem.leftBarButtonItem = selectAll
    }
    
    var selectAll : UIBarButtonItem {
        get{
            return UIBarButtonItem(title: "Select All", style: .plain, target: self, action: #selector(selectAllPressed))
        }
    }
    
    var deselectAll : UIBarButtonItem {
        get{
            return UIBarButtonItem(title: "Deselect All", style: .plain, target: self, action: #selector(deselectAllPressed))
        }
    }
    
    func selectAllPressed(_ sender:UIBarButtonItem){
        self.navigationItem.leftBarButtonItem = deselectAll
        if let sections = self.dataProperty?.sections {
            selectedContacts.removeAll()
            for section in sections {
                for contact in section.items{
                    selectedContacts.append(contact.identifier!)
                }
            }
            self.reloadEntries()
        }
    }
    func deselectAllPressed(_ sender:UIBarButtonItem){
        self.navigationItem.leftBarButtonItem = selectAll
        selectedContacts.removeAll()
        self.reloadEntries()
    }
    
    func loadContacts() {
        self.addressBook.loadContacts({[unowned self]
            (contacts: [ContactDisplayItem]?, error: Error?) in
            self.allContacts = NSArray(array: contacts!) as? [ContactDisplayItem]
            self.dataProperty = DFGContactRecordBuilder.contactDisplayData(self.allContacts)
            DispatchQueue.main.async(execute: { () -> Void in
                self.reloadEntries()
            })
        })
    }
    
    func doneButtonPressed(_ sender:AnyObject){
        let scvc:SelectedContactsTableViewController = SelectedContactsTableViewController(nibName: "SelectedContactsTableViewController", bundle: nil)
        scvc.allContacts = NSArray(array: self.selectedContacts) as! [String]
        self.navigationController?.pushViewController(scvc, animated: true)        
        
    }
     
    // MARK: TableView Delegate and Datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSections = dataProperty?.sections!.count
        
        if dataProperty?.sections!.count == nil {
            numberOfSections = 0
        }
        
        return numberOfSections!
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let upcomingSection = dataProperty?.sections![section]
        return upcomingSection!.items.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let upcomingSection = dataProperty?.sections![section]
        return upcomingSection!.name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let upcomingSection = dataProperty?.sections![indexPath.section]
        let upcomingItem = upcomingSection!.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseViewController.cellIdentifier, for: indexPath) as UITableViewCell
        self.configureCell(cell, upcomingItem: upcomingItem)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let upcomingSection = dataProperty?.sections![indexPath.section]
        let upcomingItem:ContactDisplayItem

        if tableView === strongTableView {
            upcomingItem = upcomingSection!.items[indexPath.row]
            self.manageSelectedContacts(upcomingItem)
            resultController.manageSelectedContacts(upcomingItem)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        else {
            upcomingItem = resultController.filteredProducts[indexPath.row]
            resultController.manageSelectedContacts(upcomingItem)
            self.manageSelectedContacts(upcomingItem)
            resultController.tableView.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]?{
        return sectionIndexes
    }
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int{
        if let indexFound = dataProperty?.allKeys?.index(of: title) {
            return indexFound
        }
        return index
    }
    
}

// MARK: ContactViewInterface
extension ContactViewController : ContactViewInterface {
    func updateFilteredContacts(_ data:[ContactDisplayItem]){
        DispatchQueue.main.async {[unowned self] () -> Void in
            let resultsController = self.searchController.searchResultsController as! ResultViewController
            resultsController.filteredProducts = data
            resultsController.tableView.reloadData()
        }
    }
    
    func showFetchedContactsData(_ data:ContactDisplayData!){
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
    
    func addRemoveSearchbar(_ flag:Bool){
        if flag{
            if self.searchController == nil {
                self.resultController = ResultViewController()
                
                self.resultController!.tableView.delegate = self
                
                self.searchController = UISearchController(searchResultsController: resultController)
                self.searchController.hidesNavigationBarDuringPresentation = true
                self.searchController.searchResultsUpdater = self
                self.searchController.delegate = self
                self.searchController.searchBar.sizeToFit()
                tableView.tableHeaderView = searchController.searchBar
                
                self.searchController.dimsBackgroundDuringPresentation = true // default is YES
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
    
    func addRemoveIndexedSearch(_ flag:Bool){
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
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        
        let sortDescriptors:[NSSortDescriptor] = [NSSortDescriptor(key: "name.firstName", ascending: true),
                NSSortDescriptor(key: "name.lastName", ascending: true)]
            
        let filterBlock:DFGFilterContactBlock = {
                (contact: ContactDisplayItem) -> Bool in
            if let completeName = contact.name?.fullName {
                let found:Bool = completeName.localizedCaseInsensitiveContains(strippedString)
                return found
            }else if let name = contact.name?.firstName, let lastName = contact.name?.lastName {
                let found:Bool = name.localizedCaseInsensitiveContains(strippedString) || lastName.localizedCaseInsensitiveContains(strippedString)
                return found
            }else if let name = contact.name?.firstName {
                let found:Bool = name.localizedCaseInsensitiveContains(strippedString)
                return found
            }else if let lastName = contact.name?.lastName {
                let found:Bool = lastName.localizedCaseInsensitiveContains(strippedString)
                return found
            }else{
                return false
            }
        }
            
    
        let lockQueue = DispatchQueue(label: "com.test.LockQueue", attributes: [])
        lockQueue.sync {
            let listBuilder: DFGContactListBuilder = DFGContactListBuilder()
            listBuilder.filterBlock = filterBlock
            listBuilder.sortDescriptors = sortDescriptors
            if let contactCollection:[ContactDisplayItem] = self.allContacts {
                if let contacts = listBuilder.contactListWithAllContacts(contactCollection) {
                    self.updateFilteredContacts(contacts)
                }
            }
            
            
        }

        
    }
}

extension ContactViewController : UISearchControllerDelegate{
    func presentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")

    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
        self.reloadEntries()
    }
    
}

