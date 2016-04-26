//
//  ResultViewController.swift
//  ContactUtility
//
//  Created by Hitesh on 12/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    var filteredProducts = [ContactDisplayItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BaseViewController.cellIdentifier)!
        
        let upcomingItem = filteredProducts[indexPath.row]
        self.configureCell(cell, upcomingItem: upcomingItem)
        return cell
    }

}
