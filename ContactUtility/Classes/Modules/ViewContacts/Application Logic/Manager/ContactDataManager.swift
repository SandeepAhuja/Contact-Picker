//
//  ContactDataManager.swift
//  ContactUtility
//
//  Created by Hitesh on 29/03/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import UIKit
import AddressBook
import Contacts


class ContactDataManager: NSObject {
    func fetchAllContacts(searchQuery:String?, completion:(([AnyObject]?,NSError?) -> Void)?){
            if #available(iOS 9.0, *) {
                fetchContactsFromContactApi(searchQuery, completion: completion)
            } else {
                fetchContactsFromAddressBook(searchQuery, completion: completion)
            }
    }

    @available (iOS 8,*)
    func fetchContactsFromAddressBook(searchQuery:String?, completion:(([AnyObject]?,NSError?) -> Void)?){
        let status = ABAddressBookGetAuthorizationStatus();
        if status == .Denied || status == .Restricted{
            completion!(nil,self.getError(ABAuthorizationStatus.Denied.rawValue))
            return;
        }
        var error: Unmanaged<CFError>?
        guard let addressBook: ABAddressBookRef? = ABAddressBookCreateWithOptions(nil, &error)?.takeRetainedValue() else {
            print(error?.takeRetainedValue())
            completion!(nil,error?.takeRetainedValue() as NSError?)
            return
        }
        
        ABAddressBookRequestAccessWithCompletion(addressBook) {[unowned self] granted, error in
            if !granted {
                 completion!(nil,self.getError(ABAuthorizationStatus.Denied.rawValue))
            }
            
            
            if let contactName = searchQuery where contactName.characters.count > 0 {
                if let allContacts = ABAddressBookCopyPeopleWithName(addressBook!,contactName as CFStringRef)?.takeRetainedValue(){
                    completion!(allContacts as [AnyObject],nil)
                }
            }else{
                if let allContacts = ABAddressBookCopyArrayOfAllPeople(addressBook!)?.takeRetainedValue(){
                    completion!(allContacts as [AnyObject],nil)
                }
            }
        }
    }

    
    @available(iOS 9.0, *)
    func fetchContactsFromContactApi(searchQuery:String?, completion:(([AnyObject]?,NSError?) -> Void)?){
        let store = CNContactStore()
        let authorizationStatus:CNAuthorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        if authorizationStatus == .Denied || authorizationStatus == .Restricted{
            completion!(nil,NSError(domain: "access", code: authorizationStatus.rawValue, userInfo: nil))
            return;
        }
        store.requestAccessForEntityType(CNEntityType.Contacts){ (granted: Bool, err: NSError?) in
            if !granted {
                completion!(nil,NSError(domain: "access", code: CNAuthorizationStatus.Denied.rawValue, userInfo: nil))
                return;
            }else{
                let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),CNContactIdentifierKey,CNContactPhoneNumbersKey,CNContactThumbnailImageDataKey]
                var contacts = [CNContact]()
                let fetchRequest = CNContactFetchRequest(keysToFetch:keys)
                if let name = searchQuery {
                    if name.characters.count > 0{
                        let predicate = CNContact.predicateForContactsMatchingName(name )
                        fetchRequest.predicate = predicate
                    }
                }
                
                do{
                    try store.enumerateContactsWithFetchRequest(fetchRequest) {
                        contact, stop in
                        contacts.append(contact)
                    }
                    completion!(contacts,nil)
                } catch let err{
                    print(err)
                }
                
            }
        }
        
        }
    
    func getError(status:Int)->(NSError?){
        let userInfo = [
            NSLocalizedDescriptionKey: NSLocalizedString("Operation was unsuccessful.", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Please allow the app to access your contacts through the Settings.", comment: ""),
            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("Have you tried turning it on in settings?", comment: "")
        ]
        
        let error = NSError(domain: "Access Issue", code: 1, userInfo:userInfo)
        return error
    }
}
