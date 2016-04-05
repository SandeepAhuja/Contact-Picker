//
//  SearchBarPresenter.swift
//  ContactUtility
//
//  Created by Hitesh on 01/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit

class SearchBarPresenter: NSObject,UISearchBarDelegate,AddSearchBarInteractorOutput,SearchModuleInterface {
    var wireFrame: AddSearchBarWireFrame?
    var interactor: AddSearchBarInteractorInput?
    var view : SearchModuleDelegate?
   
    func updateUI(){
        interactor?.updateUI()
    }
    
    func showSearchBar(flag:Bool){
        if flag{
            wireFrame?.addSearchBarOnViewController(view!)
            view?.addRemoveSearchbar(true)
        }else{
            wireFrame?.removeSearchBar()
            view?.addRemoveSearchbar(false)
        }
    }

}
