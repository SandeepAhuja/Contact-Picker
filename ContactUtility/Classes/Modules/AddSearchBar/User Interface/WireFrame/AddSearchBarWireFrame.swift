//
//  AddSearchBarWireFrame.swift
//  ContactUtility
//
//  Created by Hitesh on 01/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class AddSearchBarWireFrame: NSObject {
    var presenter:UISearchBarDelegate?
    var searchBar:UISearchBar?
    
    func addSearchBarOnViewController(viewController:SearchModuleDelegate){
            let view = viewController.parentView()
            let searchBar = UISearchBar()
            searchBar.delegate = presenter
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(searchBar)
            self.searchBar = searchBar
            let viewDict = ["searchbar":self.searchBar!,"view":view]
            
            let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[searchbar(==view)]|", options:[], metrics: .None, views: viewDict)
            let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[searchbar(==44)]", options: [], metrics: .None, views: viewDict)
            view?.addConstraints(horizontalConstraint)
            view?.addConstraints(verticalConstraint)
            view.layoutIfNeeded()
    }

    func removeSearchBar(){
        searchBar?.delegate = nil
        searchBar?.removeFromSuperview()
    }
}
