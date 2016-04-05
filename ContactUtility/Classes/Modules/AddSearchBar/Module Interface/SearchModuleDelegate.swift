//
//  SearchModuleDelegate.swift
//  ContactUtility
//
//  Created by Hitesh on 05/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation
import UIKit

protocol SearchModuleDelegate {
    func addRemoveSearchbar(flag:Bool)
    func parentView()-> UIView!
}