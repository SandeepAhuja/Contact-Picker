//
//  DFGTypes.swift
//  ContactUtility
//
//  Created by Hitesh on 15/04/16.
//  Copyright © 2016 Daffodil. All rights reserved.
//

import Foundation

struct DFGAddressBookAccess {
    let rawValue : Int
    static let DFGAddressBookAccessUnknown = DFGAddressBookAccess(rawValue: 0)
    static let DFGAddressBookAccessGranted = DFGAddressBookAccess(rawValue: 1)
    static let DFGAddressBookAccessDenied = DFGAddressBookAccess(rawValue: 2)
}

struct DFGContactFields : OptionSetType {
    let rawValue : Int64
    
    static let None = DFGContactFields(rawValue: 0)
    static let DFGContactFieldName = DFGContactFields(rawValue: 1 << 0)
    static let DFGContactFieldJob = DFGContactFields(rawValue: 1 << 1)
    static let DFGContactFieldThumbnail = DFGContactFields(rawValue: 1 << 2)
    static let DFGContactFieldPhonesOnly = DFGContactFields(rawValue: 1 << 3)
    
    static let DFGContactFieldPhonesWithLabels = DFGContactFields(rawValue: 1 << 4)
    static let DFGContactFieldEmailsOnly = DFGContactFields(rawValue: 1 << 5)
    static let DFGContactFieldEmailsWithLabels = DFGContactFields(rawValue: 1 << 6)
    static let DFGContactFieldAddressesWithLabels = DFGContactFields(rawValue: 1 << 7)
    static let DFGContactFieldAddressesOnly = DFGContactFields(rawValue: 1 << 8)
    static let DFGContactFieldSocialProfiles = DFGContactFields(rawValue: 1 << 9)
    static let DFGContactFieldBirthday = DFGContactFields(rawValue: 1 << 10)
    static let DFGContactFieldWebsites = DFGContactFields(rawValue: 1 << 11)
    static let DFGContactFieldRelatedPersons = DFGContactFields(rawValue: 1 << 12)
    static let DFGContactFieldLinkedRecordIDs = DFGContactFields(rawValue: 1 << 13)
    static let DFGContactFieldSource = DFGContactFields(rawValue: 1 << 14)
    static let DFGContactFieldDates = DFGContactFields(rawValue: 1 << 15)
    static let DFGContactFieldRecordDate = DFGContactFields(rawValue: 1 << 16)
    static let DFGContactFieldDefault = [DFGContactFieldName,DFGContactFieldPhonesOnly,DFGContactFieldThumbnail]
    static let DFGContactFieldAll = DFGContactFields(rawValue: 0xFFFFFFFF)
    
}

struct DFGSocialNetworkType : OptionSetType {
    let rawValue : Int
    static let DFGSocialNetworkUnknown = DFGSocialNetworkType(rawValue: 0)
    static let DFGSocialNetworkFacebook = DFGSocialNetworkType(rawValue: 1)
    static let DFGSocialNetworkTwitter = DFGSocialNetworkType(rawValue: 2)
    static let DFGSocialNetworkLinkedIn = DFGSocialNetworkType(rawValue: 3)
    static let DFGSocialNetworkFlickr = DFGSocialNetworkType(rawValue: 4)
    static let DFGSocialNetworkGameCenter = DFGSocialNetworkType(rawValue:5)
}