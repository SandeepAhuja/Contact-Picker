//
//  ResultViewController.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 12/04/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit

class ResultViewController: BaseViewController {
    var filteredProducts = [ContactDisplayItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseViewController.cellIdentifier)!
        
        let upcomingItem = filteredProducts[indexPath.row]
        self.configureCell(cell, upcomingItem: upcomingItem)
        return cell
    }

}
