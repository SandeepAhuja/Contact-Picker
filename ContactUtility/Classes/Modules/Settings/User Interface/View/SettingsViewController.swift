//
//  SettingsViewController.swift
//  ContactUtility
//
//  Created by Hitesh on 04/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController,SettingsInterface {

    @IBOutlet weak var switchIndexedSearch: UISwitch!
    @IBOutlet weak var switchSearchBar: UISwitch!
    var eventHandler:SettingsModuleInterface?
    
    @IBAction func actionSaveSettings(sender: UIBarButtonItem) {
        eventHandler?.saveSettings(switchSearchBar.on, indexedSearch: switchIndexedSearch.on)
    }
    
    @IBAction func actionCancelInterface(sender: AnyObject) {
        eventHandler?.cancelSettingsInterface()
    }

    func configureView(){
        switchIndexedSearch?.setOn(false, animated: false)
        switchSearchBar?.setOn(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
