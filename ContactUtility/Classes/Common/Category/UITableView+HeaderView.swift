//
//  UITableView+HeaderView.swift
//  ContactUtility
//
//  Created by Hitesh on 05/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    func sizeHeaderToFit(){
        let headerView = self.tableHeaderView
        headerView?.setNeedsLayout()
        headerView?.layoutIfNeeded()
        let height = headerView?.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        var headerFrame = headerView?.frame
        headerFrame?.size.height = height!
        headerView?.frame = headerFrame!
        self.tableHeaderView = headerView
    }
}