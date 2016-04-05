//
//  AddSearchBarInteractorIO.swift
//  ContactUtility
//
//  Created by Hitesh on 05/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation

protocol AddSearchBarInteractorInput {
    func updateUI()
}

protocol AddSearchBarInteractorOutput {
    func showSearchBar(flag:Bool)
}
