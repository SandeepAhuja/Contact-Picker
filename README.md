<img src="">

[![Build Status]()]()

ContactUtility is a wrapper on [AddressBook.framework](https://developer.apple.com/library/ios/documentation/AddressBook/Reference/AddressBook_iPhoneOS_Framework/_index.html), [Contacts.framework](https://developer.apple.com/library/watchos/documentation/Contacts/Reference/Contacts_Framework/index.html) that gives easy access to native address book without pain in a head.

#### Features
* Load contacts from iOS address book asynchronously if target is below iOS9.
* Load contacts from iOS Contacts asynchronously if target is greater than or equal to iOS9.
* Decide what contact data fields you need to load (for example, only name and phone number)
* Filter contacts to get only necessary records (for example, you need only contacts with specific name, number)
* Sort contacts with array of any predicates provided by AddressBook and Contacts framework(https://developer.apple.com/library/watchos/documentation/Contacts/Reference/CNContact_Class/index.html#//apple_ref/occ/clm/CNContact/predicateForContactsMatchingName:)

#### Swift
**Installation**

Just drag drop the Libray folder and select copy option.

**Load contacts**
```Swift

let addressBook = DFGAddressBook()
 self.addressBook.loadContacts({[unowned self]
            (contacts: [ContactDisplayItem]?, error: NSError?) in
            dispatch_async(dispatch_get_main_queue(),{ () -> Void in
                //update UI here
            })
        })

```


**Select contact fields bit-mask**

Available fields:
* DFGContactFieldName - *first name*, *last name*, *middle name*, *composite name*
* DFGContactFieldJob - *company (organization)*, *job title*
* DFGContactFieldThumbnail - *thumbnail* image
* DFGContactFieldPhonesOnly - array of *phone numbers* disregarding *phone labels*
* DFGContactFieldPhonesWithLabels - array *phones* with *original and localized labels*
* DFGContactFieldEmailsOnly - array of *email addresses* disregarding *email labels*
* DFGContactFieldEmailsWithLabels - array of *email addresses* with *original and localized labels*
* DFGContactFieldAddressesWithLabels - array of contact *addresses* with *original and localized labels*
* DFGContactFieldAddressesOnly - array of contact *addresses* disregarding *addresses labels*
* DFGContactFieldSocialProfiles - array of contact *profiles in social networks*
* DFGContactFieldBirthday - date of *birthday*
* DFGContactFieldWebsites - array of strings with *website URLs*
* DFGContactFieldNote - string with *notes*
* DFGContactFieldRelatedPersons - array of *related persons*
* DFGContactFieldLinkedRecordIDs - array of contact *linked records IDs*
* DFGContactFieldSource - contact *source ID* and *source name*
* DFGContactFieldDates - contact *dates* with *localized and original labels*
* DFGContactFieldRecordDate - contact record *creation date* and *modification date*
* DFGContactFieldDefault - contact *name and phones* without *labels*
* DFGContactFieldAll - all contact fields described above

> Contact `recordID` property is always available

Example of field mask with name and thumbnail:
```Swift
let addressBook = DFGAddressBook()
self.fieldsMask = DFGContactFields.DFGContactFieldDefault
```

**Filter contacts**

The most common use of this option is to filter contacts without phone number. Example:
```swift
self.addressBook.filterBlock = {
    (contact: ContactDisplayItem) -> Bool in
    if let phones = contact.phones {
        return phones.count > 0
    }
    return false
}

Filter contact on the basis of first name and last name
self.addressBook.filterBlock = {
                (contact: ContactDisplayItem) -> Bool in
if let name = contact.name?.firstName, lastName = contact.name?.lastName {
            let found:Bool = name.localizedCaseInsensitiveContainsString(strippedString) || lastName.localizedCaseInsensitiveContainsString(strippedString)
            return found
        }else if let name = contact.name?.firstName {
            let found:Bool = name
            localizedCaseInsensitiveContainsString(strippedString)
            return found
        }else if let lastName = contact.name?.lastName {
            let found:Bool = lastName
            localizedCaseInsensitiveContainsString(strippedString)
            return found
        }else{
            return false
    }
}

```

**Sort contacts**

DFGAddressBook returns unsorted contacts. So, most of users would like to sort contacts by first name and last name.
```Swift
let addressBook = DFGAddressBook()
let sortDescriptors:[NSSortDescriptor] = [NSSortDescriptor(key: "name.        firstName", ascending: true),
        NSSortDescriptor(key: "name.lastName", ascending: true)
    ]
addressBook.sortDescriptors = sortDescriptors
```

**Load contact by address book record ID**
```Swift
addressBook.loadContactByRecordID(NSNumber(integer:number), completion: {[unowned self] (contactDisplayItem, error) -> Void in
        if let contact = contactDisplayItem where error
            nil{
         //do something here
        }
                    
})

```


**Check address book access**
```Swift
switch DFGAddressBook.accessStatus(){
case .Denied:
    return DFGAddressBookAccess.DFGAddressBookAccessDenied
case .Restricted:
        return DFGAddressBookAccess.DFGAddressBookAccessDenied
case.Authorized:
        return DFGAddressBookAccess.DFGAddressBookAccessGranted
default:
        return DFGAddressBookAccess.DFGAddressBookAccessUnknown
}
```

#### Swift
**Installation**
Link two Apple Frameworks as weak status
AddressBook.framework   Status(optional)
Contacts.framework      Status(optional)
Drag and Drop Libray folder from Demo Project.
#### Contacts

If you have improvements or concerns, feel free to post [an issue](https://xyz.com/issues) and write details.

[Check out](https://xyz.com/ContactUtility) 
[Email us](mailto:sandeep.ahuja@daffodilsw.com with other ideas and projects.
