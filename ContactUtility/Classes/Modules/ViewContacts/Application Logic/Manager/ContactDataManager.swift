//
//  ContactDataManager.swift
//  ContactUtility
//
//  Created by Sandeep Ahuja on 29/03/16.
//  Copyright © 2016 DreamWorks. All rights reserved.
//

import UIKit
import Contacts

class ContactDataManager: NSObject {
    var sharedAddressbook : DFGAddressBookWrapperRef?
    override init(){
        sharedAddressbook = DFGAddressBookWrapperRef.sharedInstance
    }

    func fetchAllContacts(_ searchQuery:String?, completion:(([AnyObject]?,NSError?) -> Void)?){
        fetchContactsFromContactApi(searchQuery, completion: completion)
    }
            
    func fetchContactsFromContactApi(_ searchQuery:String?, completion:(([AnyObject]?,NSError?) -> Void)?){
        let store = CNContactStore()
        let authorizationStatus:CNAuthorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        if authorizationStatus == .denied || authorizationStatus == .restricted{
            completion?(nil,NSError(domain: "access", code: authorizationStatus.rawValue, userInfo: nil))
            return;
        }
        store.requestAccess(for: .contacts) { (granted, err) in
            if !granted {
                completion?(nil,NSError(domain: "access", code: CNAuthorizationStatus.denied.rawValue, userInfo: nil))
                return;
            }else{
                let keys:[CNKeyDescriptor] = [CNContactIdentifierKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor,CNContactThumbnailImageDataKey as CNKeyDescriptor,CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
                var contacts = [CNContact]()
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                if let name = searchQuery {
                    if name.count > 0{
                        let predicate = CNContact.predicateForContacts(matchingName: name )
                        fetchRequest.predicate = predicate
                    }
                }
                
                do{
                    try store.enumerateContacts(with: fetchRequest) {
                        contact, stop in
                        contacts.append(contact)
                    }
                    completion?(contacts,nil)
                } catch let err{
                    print(err)
                }
                
            }
        }
    }
    
    func getError(_ status:Int)->(NSError?){
        let userInfo = [
            NSLocalizedDescriptionKey: NSLocalizedString("Operation was unsuccessful.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Please allow the app to access your contacts through the Settings.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Have you tried turning it on in settings?", comment: "")
        ]
        
        let error = NSError(domain: "Access Issue", code: 1, userInfo:userInfo)
        return error
    }
}

